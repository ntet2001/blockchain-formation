--exercice 4
rle::String -> String
rle xs = foldl coding accinit chaine
           where chaine = group xs
                 accinit = []
                 coding:: [Char] -> [Char] -> [Char]
                 coding acc x = let nombre = show(length x)
                                    caractere = head x
                                in if nombre == "1"
                                   then acc ++ [caractere]
                                   else acc ++ nombre ++ [caractere]

--decoding
rld::String -> String
rld [] = []
rld chaine
  |nombre == [] = [head chaine] ++ rld (drop 1 chaine)
  |otherwise = replicate nbreocc caractere ++ rld reste
    where nbreocc = read nombre::Int
          nombre = takeWhile isDigit chaine
          caractere = head (drop tailleChiffre chaine)
          reste = drop (tailleChiffre + 1) chaine
          tailleChiffre = length nombre