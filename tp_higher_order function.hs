--exercice 1
listToint::[Int] -> Int
listToint [] = 0
listToint xs = let liste = foldl toint accInitial xs
                             where accInitial = (0,(length xs) - 1)
                                   toint::(Int,Int) -> Int -> (Int,Int)
                                   toint (acc,position) x = (acc + (x * 10 ^ position),position - 1)
               in fst liste


altMap::(a->b) -> (a->b) -> [a] -> [b]
altMap f1 f2 [] = []
altMap f1 f2 [x] = [f1 x]
altMap f1 f2 xs = let x1 = head xs
                      x2 = xs !! 1
                      function1 = f1 x1
                      function2 = f2 x2
                      resteListe = drop 2 xs
                  in function1 : function2 : altMap f1 f2 resteListe

--second version of altMap with foldl
altMap2::(Int->Int) -> (Int->Int) -> [Int] -> [Int]
altMap2 g1 g2 [] = []
altMap2 g1 g2 xs = let listeFinal = foldl alt accInit xs
                                      where accInit = ([],0)
                                            alt:: ([Int],Int) -> Int -> ([Int],Int)
                                            alt (liste,pos) x = if mod pos 2 == 0 then
                                                                (liste++[g1 x],pos+1)
                                                                else (liste++[g2 x],pos+1)
                   in fst listeFinal

--question 1
--mapFilter::(a -> b) -> (a -> Bool) -> [a] -> [b]
--mapFilter f p xs = (map f) filter p xs

--question 2
all'::(a -> Bool) -> [a] -> Bool
all' f [] = True
all' f (x:xs) = f x && all f xs

--all with fold left
all2::(Int -> Bool) -> [Int] -> Bool
all2 g xs = foldl h accInit xs
              where h::Bool -> Int -> Bool
                    h acc x = g x && acc
                    accInit = True

--question 3
any'::(a -> Bool) -> [a] -> Bool
any' g [] = False
any' g (x:xs) = g x || any g xs

--any with fold left
any2::(a -> Bool) -> [a] -> Bool
any2 g xs = foldl g1 accinitial xs
              where accinitial = False
                    g1 acc x = g x || acc

--question 4
takeWhile'::(a -> Bool) -> [a] -> [a]
takeWhile' h [] = []
takeWhile' h (x:xs)
  |h x == True = x:takeWhile h xs
  |otherwise = takeWhile h []

--question 5
dropWhile'::(a -> Bool) -> [a] -> [a]
dropWhile' f1 [] = []
dropWhile' f1 (x:xs)
  |f1 x == True = dropWhile' f1 xs
  |otherwise = x:xs

--pairs with recursion
pairs'::[a] -> [(a,a)]
pairs' [x] = []
pairs' (x:xs) = let second = xs !! 0
               in [(x,second)] ++ pairs' xs

--pairs with zip function
pairs2::[a] -> [(a,a)]
pairs2 [x] = []
pairs2 (x:xs) = zip [x] xs ++ pairs2 xs


--pairs with tails function
pairs3::[a] -> [(a,a)]
pairs3 xs = zip xs (tail xs)