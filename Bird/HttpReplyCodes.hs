module Bird.HttpReplyCodes where

import Bird.Reply
import Data.Default

ok_ :: Reply
ok_ = def

ok :: String -> IO Reply
ok body = return $ ok_ { bod = body }

notFound_ :: Reply
notFound_ = def { stat = 404, bod = "404 Not Found" }

notFound :: String -> IO Reply
notFound body = return $ notFound_ { bod = body }

forbidden_ :: Reply
forbidden_ = def { stat = 403, bod = "403 Forbidden" }

forbidden :: String -> IO Reply
forbidden body = return $ forbidden_ { bod = body } 
