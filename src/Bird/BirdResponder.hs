module Bird.BirdResponder(
  BirdResponder
, runBirdResponder
, body
, status
, param
) where

import Control.Monad.State
import Control.Monad.Reader
import Data.Default
import Data.Maybe
import Bird.Reply
import Bird.Request

type BirdResponder = StateT Reply (ReaderT Request IO)

runBirdResponder request router = 
  runReaderT (execStateT (router request) def) request

body b = do
  reply <- get
  put $ reply { replyBody = b }

status code = do
  reply <- get
  put $ reply { replyStatus = code }

param paramName = do
  request <- ask
  return $ maybe Nothing id (lookup paramName $ params request)