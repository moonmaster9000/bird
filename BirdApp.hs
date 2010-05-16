module BirdApp where
import Bird

get :: Request -> Reply

get Request { path = [] }           
  = ok { stat = 500, bod = "Hello, World!" }

get Request { path = ["hello", n] } 
  = ok { bod = "Hello, " ++ n  }

get _ = notFound
