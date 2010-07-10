module Bird.Reply where

import qualified Data.Map as Hash
import Data.Default

data Reply = 
  Reply {
    replyStatus   :: Int,
    replyHeaders  :: Hash.Map String String,
    replyBody     :: String,
    replyMime     :: String
  } deriving (Show)

instance Default Reply where
  def = Reply { replyMime = "text/html", replyBody = "", replyStatus = 200, replyHeaders = Hash.empty }
