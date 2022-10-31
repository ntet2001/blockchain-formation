import qualified Data.Monoid as M

{-========= exercise 1 ===========-}
data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
_ <> _ = Trivial

instance Monoid Trivial where
    mempty = Trivial

{-========= exercise 2 ===========-}
newtype Identity a = Identity a

instance Semigroup (Identity a) where
    Identity x <> Identity y = Identity x

instance Monoid a => Monoid (Identity a) where
    mempty = Identity mempty 

{-========= exercise 3 ===========-}
data Two a b = Two a b

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (Two a b) <> (Two u v) = Two (a M.<> u) (b M.<> v) 

instance (Monoid a, Monoid  b) => Monoid (Two a b) where
    mempty = Two mempty mempty


{-========= exercise 4 ===========-}
data Three a b c = Three a b c

instance (Semigroup a , Semigroup b , Semigroup c) => Semigroup (Three a b c) where
    (Three a b c) <> (Three u v w) = Three (a M.<> u) (b M.<> v) (c M.<> w)

instance (Monoid  a, Monoid b, Monoid c) => Monoid (Three a b c) where
    mempty = Three mempty mempty mempty



{-========= exercise 5 ===========-}
data Four a b c d = Four a b c d

instance (Semigroup a , Semigroup b , Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
    (Four a b c d) <> (Four u v w x) = Four (a M.<> u) (b M.<> v) (c M.<> w) (d M.<> x)

instance (Monoid  a, Monoid b, Monoid c, Monoid d) => Monoid (Four a b c d) where
    mempty = Four mempty mempty mempty mempty

{-========= exercise 6 ===========-}
newtype BoolConj = BoolConj Bool deriving Show

instance Semigroup BoolConj where 
    BoolConj x <> BoolConj y = BoolConj (x && y)

instance Monoid BoolConj where 
    mempty = BoolConj True 

{-========= exercise 7 ===========-}
newtype BoolDisj = BoolDisj Bool deriving Show

instance Semigroup BoolDisj where 
    BoolDisj x <> BoolDisj y = BoolDisj (x || y)

instance Monoid BoolDisj where 
    mempty = BoolDisj False

{-========= exercise 8 ===========-}
data Or a b = Fst a | Snd b deriving Show

instance Semigroup  (Or a b) where
    Fst a <> Snd b = Snd b
    Fst a <> Fst b = Fst b
    Snd a <> Fst b = Snd a 
    Snd a <> Snd b = Snd a

instance (Monoid a, Monoid b) => Monoid (Or a b) where 
    mempty = Fst mempty

{-========= exercise 11 ===========-}
data Validation a b = Failure a | Success b deriving (Eq, Show)

instance Semigroup a => Semigroup  (Validation a b) where
    Success a <> Failure b = Success a
    Failure a <> Failure b = Failure $ a M.<> b  
    Success a <> Success b = Success a
    Failure a <> Success b = Success b
main = do
    let failure :: String -> Validation String Int
        failure = Failure
        success :: Int -> Validation String Int
        success = Success
    print $ success 1 M.<> failure "blah"
    print $ failure "woot" M.<> failure "blah"
    print $ success 1 M.<> success 2
    print $ failure "woot" M.<> success 2 