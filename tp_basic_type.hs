liste::[a] -> String
liste [] = "La liste est vide"
liste [x] = "la liste a un element"
liste (x:xs) = "liste a des elements"

liste1 :: [a] -> String
liste1 (x:xs) = case (x:xs) of []->error "liste vide"
                               [x]-> "liste compte un element"
                               xs->"liste a plusieurs element"


entete::[a] -> a
entete [] = error "liste vide et n'a pas de tete"
entete (x:xs) = x

tailleListe::(Num a) => [a] -> a
tailleListe [] = 0
tailleListe (x:xs)= 1 + tailleListe xs

sommeListe::(Num a) => [a] -> a
sommeListe [] = 0
sommeListe (x:xs) = x + sommeListe xs

bmiTell::(RealFloat a)=> a -> a -> [Char]
bmiTell taille masse
       |bmi <= 18.5 = "mince"
       |bmi <= 25 = "normal"
       |bmi <= 30 = "obese"
       |otherwise = "sur-poid"
         where bmi = masse / (taille ^2)


max1::(Ord a) => a -> a -> a
max1 a b
    |a > b = a
    |otherwise = b

compare1:: (Eq a,Ord a) => a -> a -> Ordering
compare1 a b
        |a > b = GT
        |a < b = LT
        |otherwise = EQ

initials :: String -> String -> String
initials firstname lastname = [f] ++ ". " ++[l]++"."
       where (f:_) = firstname
             (l:_) = lastname


maximum' :: (Ord a) => [a] -> a
maximum' [] = error "liste vide"
maximum' [x] = x
maximum' (x:xs)
       |x > maxTail = x
       |otherwise = maximum' xs
         where maxTail = maximum' xs

replicate' :: Int -> a -> [a]
replicate' nbre a
         |nbre == 0 = []
         |otherwise = [a] ++ replicate' resteNbre a
            where resteNbre = nbre-1

take' ::(Ord a , Num a) => Int -> [a] -> [a]
take' _ [] = []
take' nbre (x:xs)
    |nbre == 0 = []
    |otherwise = [x] ++ take' (nbre-1) xs