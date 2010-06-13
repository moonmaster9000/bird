module Bird.Reply.Codes where

import qualified Data.Map as Hash
import Bird.Reply
import Data.Default


-- 200 OK default Reply record.
ok_ :: Reply
ok_ = def

-- 200 OK body convenience method.
ok :: String -> IO Reply
ok body = return $ ok_ { bod = body }


--201 Created default Reply record.
created_ :: Reply
created_ = def { stat = 201 }

--201 Created body convenience method
created :: String -> IO Reply
created body = return $ created_ { bod = body }


--202 Accepted default Reply record. 
accepted_ :: Reply
accepted_ = def { stat = 202 }

--202 Accepted body convenience method.
accepted :: String -> IO Reply
accepted body = return $ accepted_ { bod = body }


--301 Moved Permanently default Reply record (doesn't include a default redirection url). 
movedPermanently_ :: Reply
movedPermanently_ = def { stat = 301 }

--301 Moved Permanently url convenience method.
movedPermanently :: String -> IO Reply
movedPermanently url = return $ movedPermanently_ { hs = Hash.fromList [("Location", url)] }

--302 Found default Reply record (doesn't include a default redirection url).
found_ :: Reply
found_ = def { stat = 302 }

--302 Found url convenience method
found :: String -> IO Reply
found url = return $ found_ { hs = Hash.fromList [("Location", url)] }

-- 401 Unauthorized Reply record
unauthorized_ :: Reply
unauthorized_ = def { stat = 401, bod = "You are not authorized to access this resource."}

-- 401 Unauthorized Reply body convenience method
unauthorized :: String -> IO Reply
unauthorized body = return $ unauthorized_ { bod = body }

--403 Forbidden Reply record
forbidden_ :: Reply
forbidden_ = def { stat = 403, bod = "You do not have permission to access this resource."}

--403 Forbidden body convenience method
forbidden :: String -> IO Reply
forbidden body = return $ forbidden_ { bod = body }

--404 Not Found record
notFound_ :: Reply
notFound_ = def { stat = 404, bod = "404 Not Found" }

--404 Not Found body convenience method
notFound :: String -> IO Reply
notFound body = return $ notFound_ { bod = body }

--410 Gone Reply Record
gone_ :: Reply
gone_ = def { stat = 410, bod = "410 Gone" }

--410 Gone Reply Record body convenience method.
gone :: String -> IO Reply
gone body = return $ gone_ { bod = body }

--500 Internal Server Error Reply record.
internalServerError_ :: Reply
internalServerError_ = def { stat = 500, bod = "Oops... something went wrong." }

--500 Internal Server Error body convenience method.
internalServerError :: String -> IO Reply
internalServerError body = return $ internalServerError_ { bod = body }
