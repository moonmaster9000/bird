module Bird(
  module Hack, 
  module Data.Default, 
  Request(..),
  Reply(..),
  ok, 
  notFound,
  forbidden,
  envToRequest,
  replyToResponse
) where

import Hack
import Data.Default
import qualified Data.Map as Hash
import Data.ByteString.Lazy.Char8 (pack)

data Request = 
  Request { 
    verb      :: RequestMethod,
    path      :: [String],
    params    :: Hash.Map String String,
    protocol  :: Hack_UrlScheme,
    hackEnvironment :: Env
  } deriving (Show)

data Reply = 
  Reply {
    stat :: Int,
    hs   :: Hash.Map String String,
    bod  :: String
  } deriving (Show)

envToRequest :: Env -> Request
envToRequest e = 
  Request {
    verb = requestMethod e,
    path = split '/' $ pathInfo e,
    params = Hash.empty,
    protocol = hackUrlScheme e,
    hackEnvironment = e
  }

replyToResponse :: Reply -> Response
replyToResponse r = 
  Response {
    status = stat r,
    headers = Hash.toList $ hs r,
    body = pack $ bod r
  }

instance Default Request where
  def = Request { verb = GET, path = [], params = Hash.empty, protocol = HTTP, hackEnvironment = def }

instance Default Reply where
  def = Reply { bod = "", stat = 200, hs = Hash.fromList [("Content-Type", "text/html")] }

ok :: Reply
ok = def

notFound :: Reply
notFound = def { stat = 404, bod = "404 Not Found" }

forbidden = def { stat = 403, bod = "403 Forbidden" }

split :: Char -> String -> [String]
split d s
  | findSep == [] = []
  | otherwise     = t : split d s''
    where
      (t, s'') = break (== d) findSep
      findSep = dropWhile (== d) s
