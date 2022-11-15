import Data.Char
import Control.Monad
import System.IO
import System.Directory (removeFile)

-- --exercise on Type Class
-- data Color = Red | Green | Yellow 

-- instance Show Color where
--     show Red = "Red"

--             {-Here is my class YesNo-}
-- class YesNo a where
--     yesno :: a -> Bool

-- --here is the instance of my class
-- instance YesNo String  where
--     yesno "" = False
--     yesno _  = True

    
main = do
    writeFile "remove.txt" "BABYLONE"