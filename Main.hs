import Hack
import Hack.Handler.Hyena
import Bird
import BirdApp

app :: Application
app = \e -> route e

route :: Env -> IO Response
route e = response
  where 
    r = envToRequest e
    response = do 
      r <-  
        case verb r of 
          GET -> get r
          _   -> error "not supported"
      return $ replyToResponse r
main = run app
