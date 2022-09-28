--exercice on credit card validation (by using the luhn formula)

--verify if the number is > 9
superieurneuf::Int -> Int
superieurneuf x
  |x > 9 = x - 9
  |otherwise = x

--double the second step element
doubler:: String -> String
doubler chaineinit = snd (foldl double accinit chaine)
                   where chaine = reverse chaineinit
                         accinit = (1,[])
                         double::(Int,String) -> Char -> (Int,String)
                         double (indice,acc) x =if mod indice 2 == 0 then
                                                (indice + 1, show(superieurneuf((read [x]::Int) * 2)) ++ acc)
                                                else (indice + 1, [x]++acc)
--sum all the numbers
sumall::String -> Int
sumall [] = 0
sumall chaine = element + sumall queue
                 where queue = tail chaine
                       element = read [tete]::Int
                                   where tete = head chaine

--final verification
verification::Int -> Bool
verification x
  |mod x 10 == 0 = True
  |otherwise = False

--not accept alphabetics characters
nonNumerique::String -> Bool
nonNumerique xs = let taille = length xs
                      analyste = [x | x <-xs , isDigit x]
                  in  taille == length analyste

--main function
cardValidation::String -> String
cardValidation [] = "carte invalide !!!"
cardValidation [x] = "carte invalide !!!"
cardValidation xs
  |nonNumerique chaine == False = "carte invalide !!!"
  |otherwise = if verification(sumall(doubler chaine)) == True
               then "carte valide"
               else "carte invalide !!!"
                 where chaine = [x | x <- xs , isDigit x]