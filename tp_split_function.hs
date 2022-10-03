--exercice 6
--split function
split::String -> [String]
split [] = []
split (x:xs)
  |isSpace x = [] ++ split xs
  |otherwise = [x:mot] ++ split reste
     where reste = drop (tailleMot + 1) xs
           tailleMot = length mot
           mot = fst (break isSpace xs)

--join function (inverse of the split function)
join :: [String] -> String
join [] = []
join (x:xs) = x ++ " " ++ join xs