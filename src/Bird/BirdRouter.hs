module Bird.BirdRouter(
  BirdRouter
, body
, status
) where

import Control.Monad.State
import Bird.Reply
import Bird.Request

type BirdRouter = StateT Reply IO

body b = do
  reply <- get
  put $ reply { replyBody = b }

status code = do
  reply <- get
  put $ reply { replyStatus = code }

--param paramName request = lookup paramName $ params request
