module BirdApp where
import Bird
import Data.String.Utils

get, post, put, delete :: Request -> IO Reply
get Request { path = [] } = ok "Hello, World!"

get Request { path = ("hello":xs) } 
  = ok $ (++) "Hello " $ join ", " xs

get Request { path = ("echo":w:[]) }
  | length w == 4 = forbidden "We cannot echo 4 letter words."
  | otherwise     = ok w

get _ = return notFound_
post _ = return notFound_
put _ = return notFound_
delete _ = return notFound_
