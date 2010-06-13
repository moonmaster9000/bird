module BirdApp where
import Bird
import qualified Data.Map as Hash

get, post, put, delete :: Request -> IO Reply
get Request { path = [] } = 
  return $ ok_ { replyBody = "Hello World", replyMime = "text/plain" }

get Request { path = ("hello":xs) } 
  = ok $ "Hello " ++ (foldr ((++) . (++ " ")) "" xs)

get Request { path = ("echo":w:[]) }
  | length w == 4 = forbidden "We cannot echo 4 letter words."
  | otherwise     = ok w

get _ = return notFound_
post _ = return notFound_
put _ = return notFound_
delete _ = return notFound_
