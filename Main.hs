import Hack
import Hack.Handler.Hyena
import Bird
import BirdApp

app :: Application
app = \e -> return $ route e

route :: Env -> Response
route e = response
  where 
    r = envToRequest e
    response = replyToResponse $ 
      case verb r of 
        GET -> get r
        _   -> error "not supported"

main = run app
