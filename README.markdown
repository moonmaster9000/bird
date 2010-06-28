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

    get, post, put, delete :: Request -> IO Reply
    get Request { path = ("howdy":xs) } 
      = ok $ "Howdy " ++ (join ", " xs) ++ "!"

    get _ = return notFound_
    post _ = return notFound_
    put _ = return notFound_
    delete _ = return notFound_

now:

    λ curl http://localhost:3000/howdy/there/pardna
        Howdy there, pardna!

## Notes

This project is *still* in its infancy. Coming features:

* logging
* support for sending files
