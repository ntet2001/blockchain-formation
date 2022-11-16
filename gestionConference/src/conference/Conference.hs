module Conference.Conference
(
    newConference,
    firstLetter,
    listConference
    --,addSponsor
    --,listSponsor
    ,Conference
    ,Sponsor
    ,Nom
    ,Lieu
    ,Annee
    ,Dated
    ,Datef
    ,Montant
)where

import Data.Char
import Data.List
    {-=============== Here are my types statements ==================-}
type Sponsor = String
type Nom = String
type Lieu = String
type Annee = Int
type Dated = String
type Datef = String
type Montant = Int
data Conference = Conference {
    idConference :: String,
    nomConference :: String,
    lieuConference :: String,
    anneeConference :: Int,
    dateDebut :: String,
    dateFin :: String,
    montant :: Int,
    sponsors :: [String]
} deriving (Show , Read) 

instance Eq Conference where
    (==) c1 c2 = nomConference c1 == nomConference c2 && anneeConference c1 == anneeConference c2

instance Ord Conference where
    (<=) c1 c2 = nomConference c1 <= nomConference c2 && anneeConference c1 <= anneeConference c2

     {-=============== Here are my functions statements ==================-}

     --function that take the name and give the acronym
firstLetter :: String -> String
firstLetter nom = let new = words nom
    in foldr (\(x:xs) acc -> toUpper x : acc) acc new
        where acc = []

    --function that verified the date format

verifDate:: String -> Bool
verifDate chaine 
    | tailleChaine == 5 = f chaine
    | otherwise = False
        where tailleChaine = length chaine
              f :: String -> Bool
              f [v,w,x,y,z] = isDigit v  && isDigit w && x == '/' && isDigit y  && isDigit z 

     -- function to create a new Conference object
newConference :: Nom -> Lieu -> Annee -> Dated -> Datef -> Montant -> IO ()
newConference nom lieu annee dated datef montanttmp = do
    let conferencetmp = Conference {
        idConference = firstLetter nom ++ show annee,
        nomConference = nom,
        lieuConference = lieu,
        anneeConference = annee,
        dateDebut = if verifDate dated then dated else "01/01",
        dateFin = if verifDate datef then datef else "01/01",
        montant = montanttmp,
        sponsors = []
    }
        conference = idConference conferencetmp ++ " " ++ nomConference conferencetmp ++ " " ++ lieuConference conferencetmp ++ " " ++ show (anneeConference conferencetmp) ++" " ++ dateDebut conferencetmp ++ " " ++ dateFin conferencetmp ++ " " ++ show (montant conferencetmp) ++ "\n"
    appendFile "Conference.txt" conference
    putStr conference

    -- function to list a Conference in order of name and year

listConference :: IO()
listConference = do
    contenuConference <- readFile "Conference.txt"
    let newContenu = sort $ lines contenuConference
    putStrLn $ unlines newContenu

    

