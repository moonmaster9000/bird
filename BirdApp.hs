module BirdApp where
import Bird
import Data.String.Utils

get, post, put, delete :: Request -> IO Reply
get Request { path = [] } = ok_ "Hello, World!"

get Request { path = ("hello":xs) } 
  = ok_ $ (++) "Hello " $ join ", " xs

get Request { path = ("echo":w:[]) }
  | length w == 4 = forbidden_ "We cannot echo 4 letter words."
  | otherwise     = ok_ w

get _ = return notFound
post _ = return notFound
put _ = return notFound
delete _ = return notFound
