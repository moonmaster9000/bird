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
