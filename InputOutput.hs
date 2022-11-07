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
positionIndex element xs = fst $ foldl(\acc x -> if x == element then (fst acc ++ [snd acc] , snd acc + 1) else (fst acc,snd acc + 1) ) acc xs
  where acc = ([],0)

  {-==== exercise 6 ====-}
dichotomous :: Int -> [Int] -> Int
dichotomous nombre [] = -1
dichotomous nombre [x] = if nombre == x then 0 else -1
dichotomous nombre xs 
  | nombre == milieu = milieu
  | nombre > elementMax = length newtab2 + dichotomous nombre newtab1
  | otherwise = dichotomous nombre newtab2
    where newtab1 = drop milieu xs
          newtab2 = take milieu xs
          elementMax = maximum newtab2 
          milieu = div taille 2
          taille = length xs

  
  {-==== exercise 7 ====-}
func::[(Int,Int)] -> [String]
func = foldr (\(x,y) acc -> show (x-y) : acc) acc
    where acc = []

tuple :: String -> (Int,Int)
tuple [] = (0,0)
tuple xs = read xs :: (Int,Int)

callFichierExo7 = catchIOError exercise7 (\e -> putStrLn "====== The file doesn't exist =======") 

exercise7 :: IO()
exercise7 = do
  putStr "Enter the file name "
  file <- getLine
  content <- readFile file
  let transform = words content
      resultat1 = map tuple transform 
      final = func resultat1 
  writeFile "save.txt" $ unlines final


  {-==== exercise 12 ====-}
f:: [Int] -> [Int] -> [Int]
f [] [] = []
f xs [] = xs
f [] ys = ys
f xs ys 
    | mxs > mys = f ixs ys ++ [mxs]
    | mxs < mys = f xs iys ++ [mys]
    |otherwise = f ixs iys ++ [mxs,mys]
        where mxs = maximum xs
              mys = maximum ys 
              ixs = init xs 
              iys = init ys


exo12 :: IO ()
exo12 = do
  putStr "Enter the first file name : "
  fichier1 <- getLine
  putStr "Enter the second file name : "
  fichier2 <- getLine
  putStr "Enter the saved file name : "
  sauvegarde <- getLine
  contenu1 <- readFile fichier1
  contenu2 <- readFile fichier2
  let new1 = map (\x -> read x :: Int) $ words contenu1
      new2 = map (\x -> read x :: Int) $ words  contenu2
      result = f new1 new2
  writeFile sauvegarde (show result)
