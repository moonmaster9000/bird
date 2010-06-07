module BirdApp where
import Bird
import Data.String.Utils

get :: Request -> IO Reply

get Request { path = [] }           
  = return $ ok { bod = "Hello, World!" }

get Request { path = ("hello":xs) } 
  = return $ ok { bod = (++) "Hello " $ join ", " xs }

get Request { path = ("echo":w:[]) }
  | length w == 4 = return $ forbidden { bod = "We cannot echo 4 letter words." }
  | otherwise     = return $ ok { bod = w }

get _ = return $ notFound
