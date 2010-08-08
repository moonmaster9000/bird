module Bird.Request(
  Request(..)
, RequestMethod(..)
, Path
) where
import Data.Default

type Path = [String]

data RequestMethod = GET | POST | PUT | DELETE deriving(Show)

data Request = 
  Request { 
    verb          :: RequestMethod
  , path          :: Path
  , params        :: [(String, Maybe String)]
  , rawRequestUri :: String
  } deriving (Show)

instance Default Request where
  def = Request { verb = GET, path = [], params = [], rawRequestUri = "/" }
