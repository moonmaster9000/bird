module Bird.Reply where

import qualified Data.Map as Hash
import Data.ByteString.Lazy.Char8 (pack)
import Hack
import Data.Default

data Reply = 
  Reply {
    stat :: Int,
    hs   :: Hash.Map String String,
    bod  :: String
  } deriving (Show)

instance Default Reply where
  def = Reply { bod = "", stat = 200, hs = Hash.fromList [("Content-Type", "text/html")] }

replyToResponse :: Reply -> Response
replyToResponse r = 
  Response {
    status = stat r,
    headers = Hash.toList $ hs r,
    body = pack $ bod r
  }
