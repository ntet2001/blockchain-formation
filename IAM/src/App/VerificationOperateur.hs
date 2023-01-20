module App.VerificationOperateur
(
valPhoto,
verificationNom    
) 
where

    --importation of Type
    import qualified Data.ByteString.Char8 as C
    import Common.SimpleType

    {--------------------------------==== Function to validate the name ====--------------------------------}
    verificationNom :: String -> Either String Nom
    verificationNom nom 
        | length nom < 2 = Left "Nom invalide"
        | otherwise = Right nom

    {--------------------------------==== Function to validate the email ====--------------------------------}
    -- parserEmail :: Parser Email -- jean94@domain.com
    -- parserEmail = do
    --     x <- parserIdentifiant
    --     let y = parse parserPoint "" x
    --         case y of
    --             Left _ -> unexpected x
    --             Right a -> do
    --                 let u = a
    --                 char '@'
    --                 var <- many (noneOf ".")
    --                 let varParser = parse parserDomaine "" var
    --                 case varParser of
    --                     Left _ -> unexpected var
    --                     Right b -> do
    --                     let k = b
    --                     char '.'
    --                     z <- many letter <?> "extension non-valide "
    --                     let email = Email {first = u, second = k, end = z}
    --                     return email

    -- parserIdentifiant :: Parser String
    -- parserIdentifiant = do
    --     lookingFor <- many (noneOf "@")
    --     return lookingFor

    -- parserPoint :: Parser String
    -- parserPoint = do
    --     x <- many (noneOf ".") `sepBy` (char '.')
    --     if "" `elem` x then unexpected "ne doit pas commencer par '.' | contient au moins deux points consecutifs" else return $ intercalate "." x

    -- parserDomaine :: Parser String
    -- parserDomaine = do
    --     firstChar <- noneOf "-0123456789"
    --     dopo <- many (noneOf "-") `sepBy` char '-'
    --     if "" `elem` dopo then unexpected "ne commence pas par un tiret" else return (firstChar : intercalate "-" dopo)

    --verificationEmail :: String -> Either ParseError Email
    --verificationEmail email = parse parserEmail "email non valide" email

    {----------==== Function to validated the picture ====-----------------}
    verificationPhoto :: C.ByteString -> Either String Photo
    verificationPhoto photo
        | C.length photo < 25000 = Left "Photo invalide"
        | otherwise = Right photo