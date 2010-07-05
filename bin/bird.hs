module Main where
import System.Process
import System.Environment (getArgs)
import Directory

main = do
  args <- getArgs
  runArg $ head args

runArg a = 
  case a of 
    "nest"  -> runProcess "ghc" ["--make", "-O2", "Main.hs"] Nothing Nothing Nothing Nothing Nothing >> return ()
    "fly"   -> runProcess "./Main" [] Nothing Nothing Nothing Nothing Nothing >> return ()
    appName -> createBirdApp appName  

createBirdApp a = do
  createDirectory a
  writeFile (a ++ "/" ++ a ++ ".hs") (routeFile a)
  writeFile (a ++ "/" ++ "Main.hs") (mainFile a)

routeFile a = 
  "module " ++ a ++ " where\n" ++
  "import Bird\n\n" ++ 
  "get, post, put, delete :: Path -> BirdRouter ()\n" ++
  "get [] = body \"Hello, Bird!\"\n" ++
  "get _ = status 404\n" ++
  "post _ = status 404\n" ++
  "put _ = status 404\n" ++
  "delete _ = status 404\n"

mainFile a = 
  "import Hack\n" ++
  "import Hack.Handler.Happstack\n" ++
  "import Bird\n" ++
  "import qualified Control.Monad.State as S\n" ++
  "import " ++ a ++ "\n" ++ "\n" ++

  "app :: Application\n" ++
  "app = \\e -> route e\n" ++ "\n" ++

  "route :: Env -> IO Response\n" ++
  "route e = response\n" ++
  "  where \n" ++
  "    r = envToRequest e\n" ++
  "    response = do \n" ++
  "      reply <- S.execStateT (matchRequest r) def\n" ++
  "      return $ replyToResponse reply\n" ++ "\n" ++

  "matchRequest r = \n" ++
  "  case verb r of \n" ++
  "    GET -> get $ path r\n" ++
  "    POST -> post $ path r\n" ++
  "    PUT -> put $ path r\n" ++
  "    DELETE -> delete $ path r\n" ++
  "    _ -> error \"not supported\"\n" ++ "\n" ++
      
  "main = run app\n"
