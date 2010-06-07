module BirdApp where
import Bird
import Data.String.Utils

get :: Request -> Reply

get Request { path = [] }           
  = ok { bod = "Hello, World!" }

get Request { path = ("hello":xs) } 
  = ok { bod = (++) "Hello " $ join ", " xs }

get Request { path = ("echo":w:[]) }
  | length w == 4 = forbidden { bod = "We cannot echo 4 letter words." }
  | otherwise     = ok { bod = w }

get _ = notFound
