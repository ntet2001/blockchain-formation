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
    data Email = MkEmail { identifiant :: Identifiant, domaine :: String, extension :: String } deriving (Show ,Read)
    type PasswordOp = String
    type Photo = C.ByteString
    data Operateur = MKOperateur { nomOp :: NomOp, prenomOp :: PrenomOp, matricule::Matricule, email :: Email, passwordOp :: PasswordOp, photo :: Photo } deriving (Show,Read) 