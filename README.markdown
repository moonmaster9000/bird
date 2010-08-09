# Bird

A sinatra-ish web framework written in haskell, riding on top of Hack.

## Why?

Sinatra has a beautiful, simple, elegant syntax, but it's essentially an attempt to bring pattern matching to a language never intended for
pattern matching. Why not attempt something similar in a language with not just beautiful pattern matching, but with all the declarative
bells and whistles: lazy evaluation, first-class functions, currying, polymorphism?

## Install

    λ cabal update && cabal install bird

Note: make sure $HOME/.cabal/bin is in your PATH.

## Create an app

    λ bird hatch StarWars
      A fresh bird app has been created in StarWars.

## Compile your app

    λ cd StarWars
    λ bird nest 
      [1 of 2] Compiling StarWars           ( StarWars.hs, StarWars.o )
      [2 of 2] Compiling Main               ( Main.hs, Main.o )
      Linking Main ...
    λ


## Start your app (runs on port 3000)

    λ bird fly
      A bird was just spotted in flight at http://localhost:3000

## Try it out

    λ curl http://localhost:3000
      Hello, Bird!

## Improvise!

    -- StarWars.bird.hs
    import Data.String.Utils (join)

    get ["droids"] = do
      body "These aren't the droids you're looking for. Move along."
      status 404

    get ("force":xs) = do
      body $ "May the force be with you " ++ (join ", " xs) ++ "!"

    get [] = do
      name <- param "name"
      log "I'm about to greet a Jedi. Teehee!"
      body $ "Greetings, " ++ (maybe "Jedi!" id name)

Now recompile your app and start it flying:

    λ bird nest
    λ bird fly &

    λ curl -i http://localhost:3000/force/Han/Chewie

        HTTP/1.1 200 OK
        Connection: close
        Content-Type: text/html
        Date: Sat, 31 Jul 2010 14:07:17 GMT
        Server: Happstack/0.5.0.2

        May the force be with you Han, Chewie!

    λ curl -i http://localhost:3000/droids

        HTTP/1.1 404 Not Found
        Connection: close
        Content-Type: text/html
        Date: Sat, 31 Jul 2010 14:08:35 GMT
        Server: Happstack/0.5.0.2

        These aren't the droids you're looking for. Move along.


## API

You have four functions to implement: get, post, put, and delete. They each accept a Bird Request.

Inside the function body, you can use the following methods (don't worry, this is a growing list):

    param :: String -> Maybe String
    -- ex: for the request GET /droids?name=c3po,
    --     then `p <- param "name"' would bind the value `Just "c3po"' to the variable "p"

    body :: String -> BirdResponder ()
    -- takes a string and sets the Http Response body to whatever the string contained.

    status :: Integer -> BirdResponder ()
    -- takes a number, and sets the HTTP Reponse header "Status" to that number.

    mime :: String -> BirdResponder ()
    -- sets the mime type to whatever you provide
    -- ex: get [] = body "Hello World" >> mime "text/plain"

    header :: String -> String -> BirdResponder ()
    -- creates/updates a header
    -- ex: get [] = body "Hello World" >> header "X-Powered-By" "BIRD!"

    log :: String -> BirdResponder ()
    -- adds to the log
    -- ex: get [] = body "Hello World" >> log "Why did I just greet the world?"

## Notes

This project is *still* in its infancy. Coming features:

* post/put/delete http param processing
* helpers for popular html generation solutions (Hamlet, HStringTemplate, HAXML, BlazeHTML, etc.)
* WAI support
* static asset serving
* support for sending files
