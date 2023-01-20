module Division(
division
)where

division :: Int -> Int -> Maybe (Int,Int)
division _ 0 = Nothing
division x y = let q = x `div` y
                   r = x `mod` y
                in Just (q, r)