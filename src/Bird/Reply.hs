module Bird.Reply where

import qualified Data.Map as Hash
import Data.Default

data Reply = 
  Reply {
    replyStatus   :: Int
  , replyHeaders  :: Hash.Map String String
  , replyBody     :: String
  } deriving (Show)

instance Default Reply where
  def = Reply { replyBody = "", replyStatus = 200, replyHeaders = Hash.insert "Content-Type" "text/html" Hash.empty }
