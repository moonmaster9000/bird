module Bird.BirdRouter(
  BirdRouter
, body
, status
, param
) where

import Control.Monad.State
import Control.Monad.Reader
import Data.Maybe
import Bird.Reply
import Bird.Request

type BirdRouter = StateT Reply (ReaderT Request IO)

body b = do
  reply <- get
  put $ reply { replyBody = b }

status code = do
  reply <- get
  put $ reply { replyStatus = code }

param paramName = do
  request <- ask
  return $ maybe Nothing id (lookup paramName $ params request)
