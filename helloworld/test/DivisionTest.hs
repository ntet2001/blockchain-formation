module DivisionTest(
divisionTest    
)where

-----importation of division And Hspec--------------------
import Division
import Test.Hspec 
divisionTest :: IO ()
divisionTest = hspec $ do
    describe "division" $ do
        it "5 / 0 is impossible" $ do
            division 5 0 `shouldBe` Nothing
        it "5 / 1 is 5" $ do
            division 5 1 `shouldBe` Just (5,0)
            
