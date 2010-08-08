module Bird.BirdResponder where

import Control.Monad.State
import Control.Monad.Reader
import Data.Default
import Data.Maybe
import Bird.Reply
import Bird.Request
import qualified Data.Map as Hash
import Text.Printf
import System.CPUTime

type BirdResponder = StateT Reply (ReaderT Request IO)

runBirdResponder request router = do
  printf "Processing %s request of %s with %s\n" (show $ verb request) (show $ path request) (show $ params request)
  start <- getCPUTime
  reply <- runReaderT (execStateT (router request) def) request
  end   <- getCPUTime
  printf "  Response code: %s\n" (show $ replyStatus reply)
  printf "  Response time: %0.3fs\n\n" (((fromIntegral (end - start)) / (10^12)) :: Double)
  return reply

body b = do
  reply <- get
  put $ reply { replyBody = b }

status code = do
  reply <- get
  put $ reply { replyStatus = code }

param paramName = do
  request <- ask
  return $ maybe Nothing id (lookup paramName $ params request)

mime m = header "Content-Type" m

header k v = do
  reply <- get
  put $ reply { replyHeaders = Hash.insert k v $ replyHeaders reply }
