{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
module ShowParser ( 

 ) where

import Text.ParserCombinators.Parsec
import qualified Text.ParserCombinators.Parsec.Token as P
import qualified Text.Parsec as TP
import Text.ParserCombinators.Parsec.Language
import Data.List ( intercalate )
import Text.Parsec (endOfLine)
--import Text.ParserCombinators.Parsec
--import qualified Text.ParserCombinators.Parsec.Token as P
--import Text.ParserCombinators.Parsec.Language

{-

parseShow :: String -> String
parseShow = run_parser showParser

showParser :: Parser String

run_parser :: Parser a -> String -> a
run_parser p str = case parse p "" str of
        Left err -> error $ "parse error at " ++ show err
        Right val -> val
-}

--  Parser une Date --

-- date sous le format jj/mm/aaaa 
data Date = D {jour :: Jour, mois :: Mois, annee :: Annee} deriving Show
type Jour = String
type Mois = String
type Annee = Int

 

parserDeDate :: Parser Date
parserDeDate = do
        jj <- many digit 
        char '/' <|> char '-'
        mm <- many digit
        char '/' <|> char '-'
        aaaa <- many digit
        let year = read aaaa :: Int
            j = if length jj == 1 then "0"++jj else jj
        return  $ D j mm year 

parseDate :: String -> Either ParseError Date
parseDate = parse parserDeDate "" 
        
-- Vous avez recu 5150 FCFA de CHRISTELLE KENMOGNE KAMGUEN (237675101696) le 2021-01-24 19:16:13. Transaction Id: 2169460297.Reference: 1. Nouveau solde:48641 FCFA.

data LongDate = MklongDate {
        date :: Date,
        heure :: Int,
        minute :: Int,
        seconde :: Int 
} deriving Show

pl :: Parser LongDate
pl = do
        yearString <- many digit
        char '/' <|> char '-'
        monthString <- many digit
        char '/' <|> char '-'
        dayString <- many digit
        char ' ' 
        heureString <- many digit
        char '/' <|> char '-'<|> char ':'
        minuteString <- many digit
        char '/' <|> char '-'<|> char ':'
        secondeString <- many digit
        let year = read yearString :: Int
        return $ MklongDate (D dayString monthString year) (read heureString :: Int) (read minuteString :: Int) (read secondeString :: Int)

pl2 :: Parser LongDate
pl2 = do
        dayString <- many digit
        char '/' <|> char '-'
        monthString <- many digit
        char '/' <|> char '-'
        yearString <- many digit
        char ' ' 
        heureString <- many digit
        char '/' <|> char '-'<|> char ':'
        minuteString <- many digit
        char '/' <|> char '-'<|> char ':'
        secondeString <- many digit
        let year = read yearString :: Int
        return $ MklongDate (D dayString monthString year) (read heureString :: Int) (read minuteString :: Int) (read secondeString :: Int)

parseLongDate :: String -> Either ParseError LongDate
parseLongDate  = parse pl ""  

parseLongDate2 :: String -> Either ParseError LongDate
parseLongDate2  = parse pl2 ""  

data Sms = MkSms {
        montantTransaction :: Int,
        nomExpediteur :: String,
        numeroExpediteur :: String,
        dateTransaction :: Either ParseError LongDate,
        idTransaction :: String,
        referenceTransaction :: Int,
        nouveauSolde :: Int
        } deriving Show
-- Vous avez recu 5150 FCFA de CHRISTELLE KENMOGNE KAMGUEN (237675101696) le 2021-01-24 19:16:13. Transaction Id: 2169460297.Reference: 1. Nouveau solde:48641 FCFA.

ps :: Parser Sms
ps = do
    string "Vous avez recu "
    montant <- many digit
    string " FCFA de "
    nomExp <- many (letter <|> char ' ')
    char '(' 
    numeroExp <-  many digit
    char ')'
    string " le "
    chainedate <- many (digit <|> oneOf "-: ")
    char '.'
    let dateini = parseLongDate chainedate 
    string " Transaction Id: "
    idTransac <- many digit
    string ".Reference: "
    ref <- many digit
    string ". Nouveau solde:"
    solde <- many digit
    string " FCFA."
    return $ MkSms (read montant :: Int)  nomExp  numeroExp  dateini idTransac (read ref::Int) (read solde::Int)



parseSMS :: String -> Either ParseError Sms
parseSMS = parse ps ""


--parser un message UBA--
 
-- Txn: Debit Compte: 0XX..29X Valeur: XAF 500.00 Date: 31-10-2022 23:41:00 Solde: XAF 0.00 

data Uba = MkUba {
    typeTransaction :: String,
    numeroCompte :: String,
    valeur :: Double,
    dateUba :: Either ParseError LongDate,
    soldeUba :: Double
} deriving Show

pu :: Parser Uba
pu = do
    string "Txn: "
    typeT <- many letter
    string " Compte: "
    numeroC <- many (letter <|> digit <|> char '.')
    string " Valeur: XAF "
    val <- many (digit <|> char '.')
    string " Date: "
    dattU <- many (digit <|> oneOf "-: ")
    let datU2 = parseLongDate2 dattU
    string "Solde: XAF "
    soldeU <- many (digit <|> char '.')
    return $ MkUba typeT numeroC (read val:: Double) datU2 (read soldeU :: Double)



parseUba :: String -> Either ParseError Uba
parseUba = parse pu ""


parserEmail :: Parser String          -- jean94@domain.com
parserEmail = do
   first <- many lower
   chiffre <- many (lower <|> digit)
   char '@'
   second <- many lower
   char '.'
   end <- many lower
   let email = first ++ chiffre ++  "@" ++ second ++ "." ++ end
   return email
 
fonctionEmail :: String -> Either ParseError String
fonctionEmail = parse parserEmail "email non valide"









