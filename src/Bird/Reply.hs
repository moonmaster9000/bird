module Bird.Reply where

import qualified Data.Map as Hash
import Data.ByteString.Lazy.Char8 (pack)
import qualified Hack as Hack
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

replyToResponse :: Reply -> Hack.Response
replyToResponse r = 
  Hack.Response {
    Hack.status = replyStatus r,
    Hack.headers = [("Content-Type", replyMime r)] ++ (Hash.toList $ replyHeaders r),
    Hack.body = pack $ replyBody r
  }
