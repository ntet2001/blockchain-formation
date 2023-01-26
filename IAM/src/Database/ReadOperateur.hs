module Database.ReadOperateur
(
recupererOp,
recupererUnOp
)where

    {---------------------------==== Module importation ====--------------------------------}
    import qualified Common.SimpleType as ST 
    import System.IO
    import System.Environment

    {-------------------==== Function declaration of Read Operators ====---------------------}
    
    recupererOp :: IO (Either String [ST.Operateur])
    recupererOp  = do
        contenu <- readFile "SaveOperateur.txt"
        let contenu1 = lines contenu
            contenu2 = fmap read contenu1 :: [ST.Operateur]
            contenu3 = filter (\x -> ST.visibilite x == ST.Oui) contenu2 
        if null contenu3 then 
            return $ Left "Aucun Operateur enregistrer."
        else 
            return $ Right contenu3

    {-------------------==== Function declaration of Read Operators ====---------------------}
    
    recupererUnOp :: String -> IO (Either String [ST.Operateur])
    recupererUnOp mat = do
        contenu <- readFile "SaveOperateur.txt"
        let contenu1 = lines contenu
            contenu2 = fmap read contenu1 :: [ST.Operateur]
            contenu3 = filter (\x -> (ST.visibilite x == ST.Oui) && (mat == ST.matricule x)) contenu2 
        if null contenu3 then 
            return $ Left "Cette Operateur N'existe pas."
        else 
            return $ Right contenu3