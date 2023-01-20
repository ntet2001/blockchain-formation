module Main (main) where

import Lib
import Addition

main :: IO()
main = do
    let result = addition 5 4
    putStrLn $ show result