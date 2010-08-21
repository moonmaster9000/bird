module Bird.Request.UrlencodedFormParser(
  parseUrlencodedForm
) where

import Bird.Request.QueryStringParser

parseUrlencodedForm = parseQueryString
