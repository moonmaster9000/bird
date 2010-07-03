module Bird.Request.QueryStringParser(
  parseQueryString
) where

import Text.ParserCombinators.Parsec
import Numeric

parseQueryString :: String -> [(String, Maybe String)]
parseQueryString q =   
  case (parse (keyValuePair `sepBy` char '&') "Exception: Invalid Query String" q) of
    Left e -> error $ show e
    Right queryMap -> queryMap

keyValuePair = do
  k <- many1 keyCharacters
  v <- optionMaybe (char '=' >> many valueCharacters)
  return (k, v)


keyCharacters :: CharParser () Char 
keyCharacters = 
  oneOf urlBaseChars 
    <|> (char '+' >> return ' ') 
    <|> hexValue 
  
  where 
    urlBaseChars = 
      ['a'..'z'] ++
      ['A'..'Z'] ++
      ['0'..'9'] ++
      "$-_.!*'()," 

valueCharacters = keyCharacters

hexValue :: CharParser () Char 
hexValue = do 
  char '%' 
  a <- hexDigit 
  b <- hexDigit 
  let ((d, _):_) = readHex [a,b] 
  return . toEnum $ d 
