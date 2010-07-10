module Bird.Translator where
import Bird.Reply
import Bird.Request

class BirdReplyTranslator a where
  fromBirdReply :: Reply -> a

class BirdRequestTranslator a where
  toBirdRequest :: a -> Request 
