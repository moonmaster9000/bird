module Main where
import Directory
import System.Process
import System.Environment (getArgs)
import List

main = do
  args <- getArgs
  runArg $ head args

runArg a = 
  case a of 
    "nest"  -> do
      appModuleNamePath <- getCurrentDirectory
      appModuleName <- return $ head . reverse $ split '/' appModuleNamePath 
      partialRouteFile <- readFile $ appModuleName ++ ".bird.hs"
      writeFile (appModuleName ++ ".hs") ((appModulePrelude appModuleName)++ "\n" ++ partialRouteFile ++ "\n" ++ appModuleEpilogue)
      readProcess "ghc" ["--make", "-O2", "Main.hs"] ""
      files <- getDirectoryContents appModuleNamePath
      return $ map cleanGHC files
      renameFile "Main" appModuleName
      return ()
    "fly"   -> do
      appModuleNamePath <- getCurrentDirectory
      appModuleName <- return $ head . reverse $ split '/' appModuleNamePath 
      readProcess ("./" ++ appModuleName) [] ""
      return ()
    appName -> createBirdApp appName  

cleanGHC file = 
  if any (`isSuffixOf` file) [".hi", ".o"]
  then removeFile file
  else return ()

appModulePrelude appModuleName = 
  "module " ++ appModuleName ++ " where\n" ++
  "import Bird\n\n" 
-- ++ "-- get, post, put, delete :: Path -> BirdResponder ()\n"


appModuleEpilogue = 
  "get _ = status 404\n" ++
  "post _ = status 404\n" ++
  "put _ = status 404\n" ++
  "delete _ = status 404\n"
 

createBirdApp a = do
  createDirectory a
  writeFile (a ++ "/" ++ a ++ ".bird.hs") (routeFile a)
  writeFile (a ++ "/" ++ "Main.hs") (mainFile a)

routeFile a = "get [] = body \"Hello, Bird!\""

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
  "      return $ fromBirdReply reply\n\n" ++

  "matchRequest r = \n" ++
  "  case verb r of \n" ++
  "    Bird.GET -> get $ path r\n" ++
  "    Bird.POST -> post $ path r\n" ++
  "    Bird.PUT -> put $ path r\n" ++
  "    Bird.DELETE -> delete $ path r\n\n" ++
      
  "main = run app\n"

split :: Char -> String -> [String]
split d s
  | findSep == [] = []
  | otherwise     = t : split d s''
    where
      (t, s'') = break (== d) findSep
      findSep = dropWhile (== d) s

