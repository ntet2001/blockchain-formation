import System.Environment
import System.IO
import System.IO.Error

--exercise 3 read a file
-- exception when open file
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
      listeNombre = convertToInt listehacher
      lmaximum = maximum listeNombre
      lminimum = minimum listeNombre
      lsomme = sum listeNombre
      lTaille = length listeNombre
      moyenne = fromIntegral lsomme / fromIntegral lTaille
  putStrLn $ "the file name " ++ filename ++ " has " ++ show lTaille ++ " elements and the maximum is " ++ show lmaximum  putStrLn $ "the minimum is " ++ show lminimum ++ " the sum is: " ++ show lsomme ++ " and the average is " ++ show moy>-- I can now close my file
  hClose inh