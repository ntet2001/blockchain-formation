import Data.Char
import Control.Monad
import System.IO
import System.Directory (removeFile)


-- --exercise on Type Class
-- data Color = Red | Green | Yellow 

-- instance Show Color where
--     show Red = "Red"

--             {-Here is my class YesNo-}
-- class YesNo a where
--     yesno :: a -> Bool

-- --here is the instance of my class
-- instance YesNo String  where
--     yesno "" = False
--     yesno _  = True
-- type ErreurDate = String
-- type Sponsor = String
-- type Nom = String
-- type Lieu = String
-- type Annee = Int
-- type Dated = String
-- type Datef = String
-- type Montant = Int
-- data Conference = Conference {
--     idConference :: String,
--     nomConference :: String,
--     lieuConference :: String,
--     anneeConference :: Int,
--     dateDebut :: String,
--     dateFin :: String,
--     montant :: Int,
--     sponsors :: [String]
-- } deriving (Show , Read) 

-- firstLetter :: String -> String
-- firstLetter nom = let new = words nom
--     in foldr (\(x:xs) acc -> toUpper x : acc) acc new
--         where acc = []

-- newConference :: Nom -> Lieu -> Annee -> Dated -> Datef -> Montant -> IO ()
-- newConference nom lieu annee dated datef montant1 = do
--     let conference = Conference {
--         idConference = firstLetter nom ++ show annee,
--         nomConference = nom,
--         lieuConference = lieu,
--         anneeConference = annee,
--         dateDebut = if verifDate dated then dated else "01/01",
--         dateFin = if verifDate datef then datef else "01/01",
--         montant = montant1,
--         sponsors = []
--     }
--     putStrLn $ idConference conference ++ " " ++ nomConference conference ++ " " ++ lieuConference conference ++ " " ++ show (anneeConference conference) ++" " ++ dateDebut conference ++ " " ++ dateFin conference ++ " " ++ show (montant conference) 

-- verifDate:: String -> Bool
-- verifDate chaine 
--     | tailleChaine == 5 = f chaine
--     | otherwise = False
--         where tailleChaine = length chaine
--               f :: String -> Bool
--               f [v,w,x,y,z] = isDigit v  && isDigit w && x == '/' && isDigit y  && isDigit z
main :: IO ()
main = do
    a <- (++) <$> getLine <*> getLine
    putStrLn $ "the two lines concatened are : " ++ a 