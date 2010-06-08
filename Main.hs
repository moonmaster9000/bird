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
      reply <- matchRequest r
      return $ replyToResponse reply

matchRequest r = 
  case verb r of 
    GET -> get r
    POST -> post r
    PUT -> put r
    DELETE -> delete r
    _ -> error "not supported"
    
main = run app
