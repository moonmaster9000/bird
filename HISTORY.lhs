# v0.0.18

Basic param processing for POST/PUT's that have the content type "application/x-www-form-urlencoded". e.g.: 

    λ bird hatch StarWars && cd StarWars
    λ vim StarWars.bird.hs

    > post ["jedi"] = do
    >   name <- param "name"
    >   teacher <- param "teacher"
    >   case teacher of 
    >     Just "Yoda" -> body "The force is strong with this one!"      >> status 201
    >     _           -> body "Sorry. The force is not with this one."  >> status 400 

    λ bird nest 
    λ bird fly &
    λ curl -i -X POST http://localhost:3000/jedi -d name=Luke -d teacher=Yoda
        
        HTTP/1.1 201 Created
        Connection: close
        Content-Type: text/html
        Date: Sat, 21 Aug 2010 21:38:11 GMT
        Server: Happstack/0.5.0.2

        The force is strong with this one!
 

# v0.0.17
You are now free to organize your get/post/put/delete functions freely:
  
    > -- blog posts admin actions
    > get ["admin", "posts"] = do ....
    > post ["admin", "posts"] = do ....
    > put ["admin", "posts", id] = do ....
    > delete ["admin", "posts", id] = do ....

    > -- blog frontend
    > get ["posts"] = do ....
    > get ["posts", year, month, day] = do ....
    > get ["posts", year, month, day, id] = do ....
    > post ["posts", year, month, day, id, "comments"] = do .... 

In normal haskell, you'd be forced to group ALL of your get functions together, all of your post functions together, etc. etc. But bird lets you fly freely.


#v0.0.16
now includes logging! To add to the log in your get/post/put/delete methods, simply call the "log" action with a string log message.
if you want to plug in your own custom logger, set it in your MyApp/MyApp/Config.hs file: 
  
    > config = 
    >   def {
    >     birdLogger = myCustomLogger
    >   }
                           
your custom logger method signature must be: Request -> (Request -> BirdResponder ()) -> IO Reply

#v0.0.14
better "bird" command, thanks to @jasondew. "bird hatch MyApp" for a new app; "bird help" or "bird --help" for more info.

#v0.0.13
'bird nest' now cleans up after itself. 

#v0.0.12 
`mime` and `header` methods available for your get/post/put/delete function bodies. 

e.g.:
  
    > get [] = do
    >   body "Hello, World!"
    >   mime "text/plain"
    >   header "X-Powered-By" "bird"

#v0.0.11
Your application code just got simpler. bird MyApp and check it out. 'get [] = body "Hello World"' constitutes a complete and valid bird app.

#v0.0.4
Using "Rallod" for forward function application.

#v0.0.3
Hack.Handler.Happstack is now the default hack server handler. 
Also, "bird build" has been replaced with "bird nest" and "bird run" with "bird fly"

#v0.0.2
added support for query string. it's accessible in the request record from "params". 
it's a Data.Map. 
e.g.: 
    > module Blog where
    > import Bird
    
    > get, post, put, delete :: Request -> IO Reply
    > get r = ok $ "query string = " ++ (show $ params r)
    > post _ = return notFound_
    > put _ = return notFound_
    > delete _ = return notFound_
