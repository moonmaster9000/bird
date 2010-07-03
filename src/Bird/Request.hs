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

-----
-- 
-- parseQuery :: (String -> [(String, Maybe String)])
-- parseQuery q =   
--   case (parse (keyValuePair `sepBy` char '&') "Exception: Invalid Query String" q) of
--     Left e -> error $ show e
--     Right queryMap -> queryMap
-- 
-- keyValuePair = do
--   k <- many1 keyCharacters
--   v <- optionMaybe (char '=' >> many valueCharacters)
--   return (k, v)
-- 
-- 
-- keyCharacters :: CharParser () Char 
-- keyCharacters = 
--   oneOf urlBaseChars 
--     <|> (char '+' >> return ' ') 
--     <|> hexValue 
--   
--   where 
--     urlBaseChars = 
--       ['a'..'z'] ++
--       ['A'..'Z'] ++
--       ['0'..'9'] ++
--       "$-_.!*'()," 
-- 
-- valueCharacters = keyCharacters
-- 
-- hexValue :: CharParser () Char 
-- hexValue = do 
--   char '%' 
--   a <- hexDigit 
--   b <- hexDigit 
--   let ((d, _):_) = readHex [a,b] 
--   return . toEnum $ d 
