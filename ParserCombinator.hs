module ParserCombinator (

)where

{-========== writing Parser from scratch ==========-}
--Parser definition
--type Parser a = String -> Maybe (a,String)
newtype Parser a = Parser {getParser :: String -> Maybe (a,String)}

--instance Functor 
instance Functor Parser where
    fmap f (Parser x) = Parser (\xs -> do 
        (x', xs') <- x xs
        return (f x', xs')   
        )

--instance Applicative
instance Applicative Parser where
    pure x = Parser (\xs -> return (x,xs))
    (Parser f) <*> (Parser y) = Parser (\xs-> do
        (y', xs') <- y xs 
        (f' , xs'') <- f xs'
        return (f' y', xs'')
        )

--instance Monad


--implementation of a Parser
char :: Char -> Parser Char
char chaine = Parser phrase 
    where phrase [] = Nothing
          phrase (x:xs) 
            | x == chaine = Just (chaine, xs)
            | otherwise = Nothing

main :: IO()
main = do
    putStrLn "hello  world"