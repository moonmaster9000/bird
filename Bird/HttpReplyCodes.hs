module Bird.HttpReplyCodes where

import qualified Data.Map as Hash
import Bird.Reply
import Data.Default

-- 200 OK
ok_ :: Reply
ok_ = def

ok :: String -> IO Reply
ok body = return $ ok_ { bod = body }


--201 Created
created_ :: Reply
created_ = def { stat = 201 }

created :: String -> IO Reply
created body = return $ created_ { bod = body }


--202 Accepted 
accepted_ :: Reply
accepted_ = def { stat = 202 }

accepted :: String -> IO Reply
accepted body = return $ accepted_ { bod = body }


--301 Moved Permanently 
movedPermanently_ :: Reply
movedPermanently_ = def { stat = 301 }

movedPermanently :: String -> IO Reply
movedPermanently url = return $ movedPermanently_ { hs = Hash.fromList [("Location", url)] }

--302 Found 
found_ :: Reply
found_ = def { stat = 302 }

found :: String -> IO Reply
found url = return $ found_ { hs = Hash.fromList [("Location", url)] }

-- 401 Unauthorized 
unauthorized_ :: Reply
unauthorized_ = def { stat = 401, bod = "You are not authorized to access this resource."}

unauthorized :: String -> IO Reply
unauthorized body = return $ unauthorized_ { bod = body }

--403 Forbidden
forbidden_ :: Reply
forbidden_ = def { stat = 403, bod = "You do not have permission to access this resource."}

forbidden :: String -> IO Reply
forbidden body = return $ forbidden_ { bod = body }

--404 Not Found
notFound_ :: Reply
notFound_ = def { stat = 404, bod = "404 Not Found" }

notFound :: String -> IO Reply
notFound body = return $ notFound_ { bod = body }

--410 Gone
gone_ :: Reply
gone_ = def { stat = 410, bod = "410 Gone" }

gone :: String -> IO Reply
gone body = return $ gone_ { bod = body }

--500 Internal Server Error
internalServerError_ :: Reply
internalServerError_ = def { stat = 500, bod = "Oops... something went wrong." }

internalServerError :: String -> IO Reply
internalServerError body = return $ internalServerError_ { bod = body }
