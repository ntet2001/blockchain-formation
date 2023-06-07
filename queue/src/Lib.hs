{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( startApp
    , app
    , mqconnection
    ) where

import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import Network.AMQP
import qualified Data.ByteString.Lazy.Char8 as BL

data SimpleMail = MkSimpleMail
  {
    emailDestinataire      :: String,
    nomDestinataire        :: String,
    subject                :: String,
    plainText              :: String,
    htmlText              :: String
  }
$(deriveJSON defaultOptions ''SimpleMail)

type API = "users" :> Get '[JSON] String

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = users

-- myCallback :: (Message,Envelope) -> IO ()
-- myCallback (msg, env) = do
--   putStrLn $ "received message: " ++ BL.unpack (msgBody msg)
-- -- acknowledge receiving the message
--   ackEnv env


mqconnection :: IO()
mqconnection = do

-- open the network connection
  conn <- openConnection "127.0.0.1" "/" "guest" "guest"
  chan <- openChannel conn

  let message = "{\"emailDestinataire\":\"manyamaigor2001@gmail.com\", \"nomDestinataire\": \"Ntet Manyama\", \"subject\": \"Job Test\", \"plainText\": \"The content\", \"htmlText\": \"<h1>The Html Content</h1>\"}"

-- declare a queue, exchange and binding
  declareQueue chan newQueue {queueName = "myQueue"} -- create a queue and is parameters
-- create an exchange and is parameters
  declareExchange chan newExchange {exchangeName = "myExchange", exchangeType = "direct"}
  bindQueue chan "myQueue" "myExchange" "myKey"

-- subscribe to the queue
-- consumeMsgs chan "myQueue" Ack myCallback

-- publish a message to our new exchange
  publishMsg chan "myExchange" "myKey" newMsg {msgBody = BL.pack message,msgDeliveryMode = Just Persistent} -- mykey is the routing key
  print "11111111111111111111"

  getLine -- wait for keypress
  closeConnection conn
  putStrLn "connection closed"


users :: Handler String
users = undefined