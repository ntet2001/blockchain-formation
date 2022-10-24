import System.IO
import System.IO.Error
import System.Environment

{-=== exercise1 ===-}
reverseString:: String -> IO ()
reverseString [] = return ()
reverseString (x:xs) = do 
    reverseString xs
    putChar x

{-=== exercise3 ===-}
callFichierExo3 :: IO()
callFichierExo3 = fichierExo3 `catchIOError `(\e -> putStrLn "Waaoh the file does't exists")

fichierExo3 = do
  putStr "Enter a file name "
  filename <- getLine
--here I open the file in Read mode
  inh <- openFile filename ReadMode
--here I take all the contents of the file
  chaine <- hGetContents inh
  let listehacher = words chaine
      listeNombre = map (\x -> read x::Int) listehacher
      lmaximum = maximum listeNombre
      lminimum = minimum listeNombre
      lsomme = sum listeNombre
      lTaille = length listeNombre
      moyenne = fromIntegral lsomme / fromIntegral lTaille
  putStrLn $ "the file name " ++ filename ++ " has " ++ show lTaille ++ " elements and the maximum is  " ++ show lmaximum  ++ "the minimum is " ++ show lminimum ++ " the sum is: " ++ show lsomme ++ " and the average is " ++ show moyenne
-- I can now close my file
  hClose inh


  {-==== exercise 4 ====-}
-- here I implement the lines of the matrix  
ligne :: Int -> Int -> String
ligne x 0 = show (x,0)
ligne x y = do
  ligne x reste ++ show (x, y)
    where reste = y - 1

--here I implement the square matrix
matriceCarree::Int -> Int -> IO()
matriceCarree 0 y = putStrLn $ ligne 0 y
matriceCarree x y = do
  matriceCarree reste y 
  putStrLn $ ligne x y 
    where reste = x - 1

  {-==== exercise 5 ====-}
positionIndex :: Int -> [Int] -> [Int]
positionIndex element xs = fst $ foldl(\acc x -> if x == element then ((fst acc) ++ [snd acc] , (snd acc) + 1) else (fst acc,(snd acc) + 1) ) acc xs
  where acc = ([],0)


