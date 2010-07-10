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

    λ bird MyApp 

## Compile your app

    λ cd MyApp
    λ bird nest 
      [1 of 2] Compiling MyApp            ( MyApp.hs, MyApp.o )
      [2 of 2] Compiling Main             ( Main.hs, Main.o )
      Linking Main ...
    λ 


## Start your app (runs on port 3000)

    λ bird fly

## Try it out
    
    λ curl http://localhost:3000
      Hello, Bird!
    
    λ curl http://localhost:3000?name=moonmaster9000
      Hello, moonmaster9000



## Improvise!
    
    -- MyApp.hs
    module MyApp where
    import Bird
    import Data.String.Utils

    get, post, put, delete :: Path -> BirdRouter ()
    
    get ["droids"] = do
      body "These aren't the droids you're looking for. Move along."
      status 404

    get [] = do
      name <- param "name"
      body $ "Hello, " ++ (maybe "Bird!" id name)

    get ("howdy":xs) = body $ "Howdy " ++ (join ", " xs) ++ "!"


    get _ = status 404
    post _ = status 404
    put _ = status 404
    delete _ = status 404

now:

    λ curl http://localhost:3000/howdy/there/pardna
        Howdy there, pardna!

    λ curl http://localhost:3000/droids
        Nothing to see here. Move along.


## API

You have four functions to implement: get, post, put, and delete. They each accept a Bird Request. 

Inside the function body, you can use the following methods (don't worry, this list will grow): 
    
    param :: String -> String
    -- ex: for the request GET /droids?name=c3po, 
    --     then `p <- param "name"' would bind the value "c3po" to the variable "p"

    body :: String -> BirdRouter ()
    -- takes a string and sets the Http Response body to whatever the string contained.

    status :: Integer -> BirdRouter
    -- takes a number, and sets the HTTP Reponse header "Status" to that number.

## Notes

This project is *still* in its infancy. Coming features:

* logging
* support for sending files
