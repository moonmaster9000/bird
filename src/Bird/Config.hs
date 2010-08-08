module Bird.Config where 

import Data.Default
import Bird.Logger
import Bird.Request
import Bird.Reply
import Bird.BirdResponder

type Router = Request -> BirdResponder ()

data BirdConfig = 
  BirdConfig {
    staticDir :: String
  , birdLogger :: Request -> Router -> IO Reply
  }

instance Default BirdConfig where
  def = 
    BirdConfig {
      staticDir   = "static"
    , birdLogger  = defaultLogger
    }
