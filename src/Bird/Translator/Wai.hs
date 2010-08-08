{-# LANGUAGE OverloadedStrings #-}
module Bird.Translator.Wai(
  fromBirdReply
, toBirdRequest
) where


import qualified Network.Wai as Wai
import Network.Wai.Enumerator (fromLBS)
import qualified Data.Map as Hash
import Bird.Translator
import Bird.Request
import Bird.Reply
import Bird.Request.QueryStringParser
-- import qualified Data.ByteString.Char8 as B8

instance BirdReplyTranslator Wai.Response where
  fromBirdReply r = 
    Wai.Response {
      Wai.status = replyStatus r,
      Wai.responseHeaders = (Hash.toList $ Hash.insertWith insertUnlessPresent "Content-Type" "text/html" $ replyHeaders r),
      Wai.responseBody = ResponseLBS $ replyBody r
    }
    where
      insertUnlessPresent = flip const

instance BirdRequestTranslator Wai.Request where
  toBirdRequest waiRequest = 
    Request {
      verb = waiRequestMethodToBirdRequestMethod $ Wai.requestMethod waiRequest
    , path = split '/' $ Wai.pathInfo e
    , params = parseQueryString $ Wai.queryString e
    }



instance BirdReplyTranslator Wai.Response where
  fromBirdReply r = 
    Wai.Response {
      Wai.status = toWaiStatus $ replyStatus r,
      Wai.responseHeaders = (Hash.toList $ Hash.insertWith insertUnlessPresent "Content-Type" "text/html" $ replyHeaders r),
      Wai.responseBody = ResponseLBS $ replyBody r
    }
    where
      insertUnlessPresent = flip const

instance BirdRequestTranslator Wai.Request where
  toBirdRequest waiRequest = 
    Request {
      verb = waiRequestMethodToBirdRequestMethod $ Wai.requestMethod waiRequest
    , path = split '/' $ Wai.pathInfo e
    , params = parseQueryString $ Wai.queryString e
    }

toWaiStatus statusCode = 
  case statusCode of 
    200 -> Wai.status200
    301 -> Wai.status301
    302 -> Wai.status302
    303 -> Wai.status303
    400 -> Wai.status400
    401 -> Wai.status401 
    403 -> Wai.status403
    404 -> Wai.status404
    405 -> Wai.status405
    500 -> Wai.status500
    _   -> Wai.Status statusCode $ "HTTP Status"

waiRequestMethodToBirdRequestMethod rm = 
  case rm of 
    "GET" -> GET
    "PUT" -> PUT
    "POST" -> POST
    "DELETE" -> DELETE
    _ -> error "unknown request method!"

split :: Char -> String -> [String]
split d s
  | findSep == [] = []
  | otherwise     = t : split d s''
    where
      (t, s'') = break (== d) findSep
      findSep = dropWhile (== d) s
