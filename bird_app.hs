module BirdApp where

import Data.Default
import qualified Data.Map as M

data HttpVerb = GET | POST | PUT | DELETE | HEAD deriving (Show)

data Request = 
  Request { 
    verb :: HttpVerb,
    path :: [String],
    params :: M.Map String String 
  } deriving (Show)

data Response = 
  Response {
    status :: Int,
    body   :: String
  } deriving (Show)

instance Default Request where
  def = Request { verb = GET, path = [], params = M.empty }

instance Default Response where
  def = Response { body = "", status = 200 }

ok :: Response
ok = def

notFound :: Response
notFound = def { status = 404, body = "404 Not Found" }

home :: Request
home = def 

route :: Request -> Response
route r = 
  case verb r of 
    GET -> get r
    _   -> error "not supported"

get :: Request -> Response
get r = 
  case p of
    []            -> ok { body = "Hello, World!" }
    ["hello", n]  -> ok { body = "Hello, " ++ n  }
    _             -> notFound
  where 
    p = path r   

-- 
-- post :: Request -> Response
-- post r
--   | articlesPath && valid ps = created { body = "We created your resource! (Not Really)" }
--   | articlesPath             = invalid { body = "There were some problems with your submission. Try again" }
--   where
--     p = path r
--     ps = params r
--     articlesPath = p == ["articles"]
-- 
