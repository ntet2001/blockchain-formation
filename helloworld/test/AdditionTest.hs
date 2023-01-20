module AdditionTest(
testadd
)where

import Test.Hspec
import Addition
import Test.QuickCheck
-----------------------------Functions for addition properties-----------------------------
propAdd1:: Int -> Int -> Bool
propAdd1 x y = addition x y == addition y x

propAdd2:: Int -> Int -> Int -> Bool
propAdd2 x y z = (addition x y) `addition` z == x `addition` (addition y z)

propAdd3:: Int -> Int -> Bool
propAdd3 x y 
  | x == 0 = addition x y == y
  | y == 0 = addition x y == x
  | otherwise = addition x y == addition y x

testadd :: IO ()
testadd = hspec $ do
    describe "Addition" $ do
        it "-2 + 3 is 1" $ do
          addition (-2) 3 `shouldBe` 1
        it "(-2 + 3) == (3 - 2)" $ do
          addition (-2) 3 `shouldBe` addition 3 (-2)
        it "addition should be commutative with *arbitrary* elements" $ do
          quickCheck propAdd1
        it "addition should be associative with *arbitrary* elements" $ do
          quickCheck propAdd2
        it "addition should have identity function with *arbitrary* elements" $ do
          quickCheck propAdd3