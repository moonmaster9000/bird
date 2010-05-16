module BirdApp where
import Bird

get :: Request -> Reply

get Request { path = [] }           
  = ok { bod = "Hello, World!" }

get Request { path = ["hello", n] } 
  = ok { bod = "Hello, " ++ n  }

get _ = notFound
