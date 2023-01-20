module Common.SimpleType 
(
Nom, 
NomOp, 
PrenomOp, 
Matricule,
Identifiant,
Email(..),
PasswordOp,
Photo,
Operateur(..),    
)
where

    {---------------------------=== Importation ===----------------------------------}
    import qualified Data.ByteString.Char8 as C    

    {---------------------------=== Types Definitions ===---------------------------}
    type Nom = String 
    type NomOp = Nom 
    type PrenomOp = Nom 
    type Matricule = String
    type Identifiant = String
    data Email = MkEmail { identifiant :: Identifiant, domaine :: String, extension :: String } deriving Read
    type PasswordOp = String
    type Photo = C.ByteString
    data Operateur = MKOperateur { nomOp :: NomOp, prenomOp :: PrenomOp, matricule::Matricule, email :: Email, passwordOp :: PasswordOp, photo :: Photo } deriving Read 

    --instance Show of Email
    instance Show Email where
        show y = if null (identifiant y)
            then error "identifiant nul"
            else identifiant y ++ "@" ++ domaine y ++ "." ++ extension y

    -- instance Show of Operateur
    instance Show Operateur where
        show operateur = "{\"name\" : " ++ nomOp operateur ++ ";\n"++
            "\"prenom\" : " ++ prenomOp operateur ++ ";\n"++
            "\"matricule\" : " ++ matricule operateur ++ ";\n"++
            "\"email\" : " ++ show (email operateur) ++ ";\n"++
            "\"password\" : " ++ passwordOp operateur ++ ";\n" ++
            "\"photo\" : " ++ C.unpack (photo operateur) ++ ";\n}"