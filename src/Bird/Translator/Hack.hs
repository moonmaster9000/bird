module Bird.Translator.Hack(
  fromBirdReply
, toBirdRequest
) where

import qualified Hack as Hack
import qualified Data.Map as Hash
import Bird.Translator
import Bird.Request
import Bird.Reply
import Bird.Request.QueryStringParser
import Data.ByteString.Lazy.Char8 (pack)

instance BirdReplyTranslator Hack.Response where
  fromBirdReply r = 
    Hack.Response {
      Hack.status = replyStatus r,
      Hack.headers = (Hash.toList $ Hash.insertWith insertUnlessPresent "Content-Type" "text/html" $ replyHeaders r),
      Hack.body = pack $ replyBody r
    }
    where
      insertUnlessPresent = flip const

instance BirdRequestTranslator Hack.Env where
  toBirdRequest e = 
    Request {
      verb = hackRequestMethodToBirdRequestMethod $ Hack.requestMethod e
    , path = split '/' $ Hack.pathInfo e
    , params = parseQueryString $ Hack.queryString e
    }


hackRequestMethodToBirdRequestMethod rm = 
  case rm of 
    Hack.GET -> GET
    Hack.PUT -> PUT
    Hack.POST -> POST
    Hack.DELETE -> DELETE
    _ -> error "unknown request method!"

split :: Char -> String -> [String]
split d s
  | findSep == [] = []
  | otherwise     = t : split d s''
    where
      (t, s'') = break (== d) findSep
      findSep = dropWhile (== d) s
