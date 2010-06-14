module Bird.Reply.Codes where

import qualified Data.Map as Hash
import Bird.Reply
import Data.Default


-- 200 OK default Reply record.
ok_ :: Reply
ok_ = def

-- 200 OK body convenience method.
ok :: String -> IO Reply
ok body = return $ ok_ { replyBody = body }


--201 Created default Reply record.
created_ :: Reply
created_ = def { replyStatus = 201 }

--201 Created body convenience method
created :: String -> IO Reply
created body = return $ created_ { replyBody = body }


--202 Accepted default Reply record. 
accepted_ :: Reply
accepted_ = def { replyStatus = 202 }

--202 Accepted body convenience method.
accepted :: String -> IO Reply
accepted body = return $ accepted_ { replyBody = body }


--301 Moved Permanently default Reply record (doesn't include a default redirection url). 
movedPermanently_ :: Reply
movedPermanently_ = def { replyStatus = 301 }

--301 Moved Permanently url convenience method.
movedPermanently :: String -> IO Reply
movedPermanently url = return $ movedPermanently_ { replyHeaders = Hash.fromList [("Location", url)] }

--302 Found default Reply record (doesn't include a default redirection url).
found_ :: Reply
found_ = def { replyStatus = 302 }

--302 Found url convenience method
found :: String -> IO Reply
found url = return $ found_ { replyHeaders = Hash.fromList [("Location", url)] }

-- 401 Unauthorized Reply record
unauthorized_ :: Reply
unauthorized_ = def { replyStatus = 401, replyBody = "You are not authorized to access this resource."}

-- 401 Unauthorized Reply body convenience method
unauthorized :: String -> IO Reply
unauthorized body = return $ unauthorized_ { replyBody = body }

--403 Forbidden Reply record
forbidden_ :: Reply
forbidden_ = def { replyStatus = 403, replyBody = "You do not have permission to access this resource."}

--403 Forbidden body convenience method
forbidden :: String -> IO Reply
forbidden body = return $ forbidden_ { replyBody = body }

--404 Not Found record
notFound_ :: Reply
notFound_ = def { replyStatus = 404, replyBody = "404 Not Found" }

--404 Not Found body convenience method
notFound :: String -> IO Reply
notFound body = return $ notFound_ { replyBody = body }

--410 Gone Reply Record
gone_ :: Reply
gone_ = def { replyStatus = 410, replyBody = "410 Gone" }

--410 Gone Reply Record body convenience method.
gone :: String -> IO Reply
gone body = return $ gone_ { replyBody = body }

--500 Internal Server Error Reply record.
internalServerError_ :: Reply
internalServerError_ = def { replyStatus = 500, replyBody = "Oops... something went wrong." }

--500 Internal Server Error body convenience method.
internalServerError :: String -> IO Reply
internalServerError body = return $ internalServerError_ { replyBody = body }
