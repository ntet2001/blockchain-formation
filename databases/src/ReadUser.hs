{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE CPP, BangPatterns, ScopedTypeVariables #-}

module ReadUser where 
    import Data.Aeson
    import Data.Aeson.TH
    import Network.Wai
    import Network.Wai.Handler.Warp
    import Servant
    import Database.MySQL.Simple
    import Database.MySQL.Simple.QueryResults
    import Database.MySQL.Simple.Result

    data User = User {userId :: Int
        ,userFirstName :: String
        ,userLastName :: String
    } deriving (Eq, Show)
    $(deriveJSON defaultOptions ''User)

    instance QueryResults User where
        convertResults [fa,fb,fc] [va,vb,vc] = User a b c
            where   !a = convert fa va
                    !b = convert fb vb 
                    !c = convert fc vc
        convertResults fs vs = convertError fs vs 3

    getUsers:: IO [User]
    getUsers = do
        conn <- connect defaultConnectInfo {connectHost = "localhost", connectDatabase = "haskell", connectPassword = "ntetigor2001", connectUser = "root", connectPort = 3306}
        users <- query_ conn "select * from users"
        close conn
        return users