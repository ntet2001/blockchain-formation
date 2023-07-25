{-========================================= Importations ===============================================-}
import      Data.List 


--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- Exercise 1 on given a list of digit of an Input list of Integer --------------------------------------------
unitdigit :: [Int] -> [Int]
unitdigit = map (`mod` 10)

--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- Exercise 2 on given a list of palindromes of an Input list of String ---------------------------------------
data Result = MkResult {nbreDePalindrome :: Int, listePalindrome :: [String]}
instance Show Result where
    show (MkResult nb ls) = show nb ++ " palindromes dont : " ++ show ls

palindrome :: String -> String
palindrome xs = show $ MkResult nbreMots listeMots 
    where listeMots = filter (\mot -> mot == reverse mot) (words xs)
          nbreMots  = length listeMots

--------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- Exercise 3 on given a list of amstrong's numbers of an Input list of integer -------------------------------
