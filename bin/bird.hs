module Main where
import System.Process
import System.Environment (getArgs)
import Directory

main = do
  args <- getArgs
  runArg $ head args

runArg a = 
  case a of 
    "nest"  -> readProcess "ghc" ["--make", "-O2", "Main.hs"] "" >> return ()
    "fly"   -> readProcess "./Main" [] "" >> return ()
    appName -> createBirdApp appName  

createBirdApp a = do
  createDirectory a
  writeFile (a ++ "/" ++ a ++ ".hs") (routeFile a)
  writeFile (a ++ "/" ++ "Main.hs") (mainFile a)

routeFile a = 
  "module " ++ a ++ " where\n" ++
  "import Data.Maybe\n" ++
  "import Bird\n\n" ++ 
  "get, post, put, delete :: Path -> BirdResponder ()\n" ++
  "get [] = do\n" ++
  "  name <- param $ \"name\"\n" ++
  "  body $ \"Hello, \" ++ (maybe \"Bird!\" id name)\n\n" ++

  "get _ = status 404\n" ++
  "post _ = status 404\n" ++
  "put _ = status 404\n" ++
  "delete _ = status 404\n"

mainFile a = 
  "import Hack\n" ++
  "import qualified Hack as Hack\n" ++ 
  "import Hack.Handler.Happstack\n" ++
  "import Bird\n" ++
  "import qualified Bird as Bird\n" ++
  "import Bird.Translator.Hack\n" ++
  "import qualified Control.Monad.State as S\n" ++
  "import qualified Control.Monad.Reader as R\n" ++
  "import " ++ a ++ "\n" ++ "\n" ++

  "app :: Application\n" ++
  "app = \\e -> route e\n" ++ "\n" ++

  "route :: Env -> IO Response\n" ++
  "route e = response\n" ++
  "  where \n" ++
  "    req = toBirdRequest e\n" ++
  "    response = do \n" ++
  "      reply <- runBirdResponder req matchRequest\n" ++
  "      return $ fromBirdReply reply\n" ++ "\n" ++

  "matchRequest r = \n" ++
  "  case verb r of \n" ++
  "    Bird.GET -> get $ path r\n" ++
  "    Bird.POST -> post $ path r\n" ++
  "    Bird.PUT -> put $ path r\n" ++
  "    Bird.DELETE -> delete $ path r\n" ++
      
  "main = run app\n"
