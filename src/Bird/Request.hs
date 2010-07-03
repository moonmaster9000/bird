module Bird.Request(
  Request(..),
  envToRequest
) where

import Hack
import Data.Default
import Data.ByteString.Lazy.Char8 (pack)
import Rallod
import Text.ParserCombinators.Parsec
import Numeric
import Bird.Request.QueryStringParser
import qualified Data.Map as Hash

data Request = 
  Request { 
    verb      :: RequestMethod,
    path      :: [String],
    params    :: Hash.Map String (Maybe String),
    protocol  :: Hack_UrlScheme,
    hackEnvironment :: Env
  } deriving (Show)

instance Default Request where
  def = Request { verb = GET, path = [], params = Hash.empty, protocol = HTTP, hackEnvironment = def }

envToRequest :: Env -> Request
envToRequest e = 
  Request {
    verb = requestMethod e,
    path = split '/' $ pathInfo e,
    params = Hash.fromList $ parseQueryString $ queryString e,
    protocol = hackUrlScheme e,
    hackEnvironment = e
  }

split :: Char -> String -> [String]
split d s
  | findSep == [] = []
  | otherwise     = t : split d s''
    where
      (t, s'') = break (== d) findSep
      findSep = dropWhile (== d) s
