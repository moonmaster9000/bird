module Bird.Logger where

import Bird.BirdResponder
import Bird.Reply
import Bird.Request
import Text.Printf
import qualified Data.String.Utils as StringUtils (join)
import System.CPUTime

defaultLogger request router = do
  let logPrelude = "\n" ++ (show $ verb request) ++ " " ++ (show $ rawRequestUri request)
  start <- getCPUTime
  (reply, logMessages) <- runBirdResponder request router 
  end <- getCPUTime
  let logEpilogue = (printf "  Response code: %s" (show $ replyStatus reply)) ++ (printf "\n  Response time: %0.3fs" (((fromIntegral (end - start)) / (10^12)) :: Double))
  putStrLn $ (StringUtils.join "\n" ([logPrelude] ++ logMessages ++ [logEpilogue])) ++ "\n"
  return reply
