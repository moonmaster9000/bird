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

## Start your app (runs on port 3000)

    λ bird fly

## Try it out
    
    λ curl http://localhost:3000
      404 Not Found

## Improvise!
    
    -- MyApp.hs
    module MyApp where
    import Bird
    import Data.String.Utils

    get, post, put, delete :: Path -> BirdRouter ()
    get ("howdy":xs) = body $ "Howdy " ++ (join ", " xs) ++ "!"

    get ["droids"] = do
      body "Nothing to see here. Move along."
      status 404

    get _ = status 404
    post _ = status 404
    put _ = status 404
    delete _ = status 404

now:

    λ curl http://localhost:3000/howdy/there/pardna
        Howdy there, pardna!

    λ curl http://localhost:3000/droids
        Nothing to see here. Move along.


## Notes

This project is *still* in its infancy. Coming features:

* logging
* support for sending files
