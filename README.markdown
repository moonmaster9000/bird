# Bird

A sinatra-ish web framework written in haskell, riding on top of Hack. 

## Why?

Sinatra has a beautiful, simple, elegant syntax, but it's essentially an attempt to bring pattern matching to a language never intended for 
pattern matching. Why not attempt something similar in a language with not just beautiful pattern matching, but with all the declarative 
bells and whistles: lazy evaluation, first-class functions, currying, polymorphism.

## Install

    git clone git://github.com/moonmaster9000/bird.git

## Compile

    bird# ghc --make -O2 Main.hs

## Start the app

    bird# ./main &
    bird# curl http://localhost:3000
      Hello, World!
    bird# curl http://localhost:3000/hello/github
      Hello, github!
    bird# curl http://localhost:3000/hi
      404 Not Found

## Improvise!
    
    -- BirdApp.hs
    module BirdApp where
    import Bird

    get :: Request -> Reply

    get Request { path = [] }           
      = ok { bod = "Howdy, y'all!" }

    get Request { path = ["howdy", n] } 
      = ok { bod = "Howdy, " ++ n  }

    get _ = notFound

## Notes

This project is in it's infancy. Like, it was seriously just born. It's not even close to being feature-complete yet. It's not even sure
what feature complete means yet. Stay tuned.

