--UnsignedDigitsInBaseToDecimal (convertion from a base between 2 - 10 To Decimal)
unsignedDigitsInBaseToDecimal:: Int -> [Int] -> Int
unsignedDigitsInBaseToDecimal _ [] = 0
unsignedDigitsInBaseToDecimal base xs
  |base < 2 = 0
  |base > 10 = 0
  |otherwise = if verification2 base xs
               then 0
               else convertion xs base
               where convertion::[Int] -> Int ->Int
                     convertion xs base = fst $ foldl( \(acc,exp) x -> if exp == length xs then (acc,exp) else (acc+(x*(base^exp)),exp+1) ) (0,0) xs
                     verification2:: Int -> [Int] -> Bool
                     verification2 base liste = let newListe = filter (`elem` [0..end]) liste
                                               in length newListe < length liste
                                                 where end = base - 1

--exercice 7
--new data type book
data Book = Book {
  title::String
  ,author::String
  ,isCheckedOut::Bool
}deriving Show

--function on book
newBook:: Book -> String
newBook livre = title livre ++ " of " ++ author livre ++ " is " ++ "available"


--exercice 8
isJust::Maybe a -> Bool
isJust (Just a) = True
isJust Nothing = False

mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b f Nothing = b
mayybee b f (Just a) = f a