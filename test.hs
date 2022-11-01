import System.IO
import Data.List
import Data.Char

{-===== Here we create our type ======-}
data Type = I | E deriving (Show , Eq,Read)
data Client = Client {
    email :: String,
    numero :: String,
    adresse :: String,
    type' :: Type,
    nom :: String
} deriving Show

instance Eq Client where
    (==) client1 client2 = email client1 == email client2 && numero client1 == numero client2

{-===== Here is our function to read and show the list of client ======-}
readFileContent :: String -> IO [Client]
readFileContent fichier = do
    contenu <- readFile fichier
    let sortie = map words $ lines contenu
    return (map correspondance sortie)  

correspondance :: [String] -> Client
correspondance (x:y:z:w:xs) = Client {
    email = x,
    numero = y,
    adresse = z,
    type' = read w :: Type,
    nom = f xs 
}
{-===== Here is our function to format the name of client ======-}
    where f :: [String] -> String
          f [] = []
          f (x:xs) = x ++ " " ++ f xs

{-===== Here is our function to read and show the list of client without doublons ======-}
--function d'aide
displayFileContenthelper ::  [Client] ->  [Client]
displayFileContenthelper [] = []
displayFileContenthelper [x] = [x] 
displayFileContenthelper (x:xs) = if  x `elem`xs  
    then displayFileContenthelper xs
    else x:displayFileContenthelper xs

displayFileContent :: String -> IO [Client]
displayFileContent fichier = do
    contenu <- readFile fichier
    let sortie = map words $ lines contenu
        resultat = map correspondance sortie
    return (displayFileContenthelper resultat)
