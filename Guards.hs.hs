module Guards(
mapl
,mapr
,maximuml
,maximumr
,reversel
,headr
)where

--function fold (foldl et foldr)
--map function implemented with fold
mapl :: (a -> b) -> [a] -> [b]
mapl f xs = foldl(\acc x -> f x : acc) [] xs

mapr::(a -> b) -> [a] -> [b]
mapr f xs = foldr(\x acc -> f x : acc) [] xs

--maximum function implemented with fold
maximuml :: (Num a , Ord a) => [a] -> a
maximuml xs = foldl(\acc x -> if x > acc then x else acc) 0 xs

maximumr :: (Num a , Ord a) => [a] -> a
maximumr xs = foldr(\x acc -> if x > acc then x else acc) 0 xs

--reverse function with foldl
reversel:: [a] -> [a]
reversel = foldl(\acc x -> x:acc) [] 

--head function with foldr
headr ::Num a => [a] -> a
headr  = foldr(\x acc -> x) 0 