{-exercises on monoid and semigroup-}
--monoid and semigroup
newtype All = All { getAll :: Bool } deriving (Eq, Ord, Read, Show,Bounded)
newtype Any = Any { getAny :: Bool } deriving (Eq, Ord, Read, Show,Bounded)
data Ordering1 = LT1 | EQ1 | GT1 deriving (Ord , Show , Eq, Read)
data Maybe1 a = Nothing1 | Just1 a  deriving (Show)
newtype First a = First { getFirst :: Maybe a } deriving (Eq, Ord,Read, Show)

compare' ::(Ord a) => a -> a -> Ordering1
compare' a b 
    | a < b = LT1
    | a > b = GT1
    |otherwise = EQ1
    

--semigroup 
--exo1
instance Semigroup Any where
    (Any x) <> (Any y) = Any $ x || y
--exo2
instance Semigroup All where
    (All x) <> (All y) = All $ x && y
--exo3
instance Semigroup Ordering1 where
    x <>  y = compare'  x y
--exo4 
instance (Semigroup a) =>Semigroup (Maybe1 a) where
    Nothing1 <> x = x
    x <> Nothing1 = x
    (Just1 x) <> (Just1 y) = Just1 (x <> y)  

--exo5
instance (Semigroup a) => Semigroup (First a)  where
   First x <> First Nothing = First x
   First Nothing <> First x = First x
   First x <> First y = First (x <> y)


--monoid 
--exo1
instance Monoid Any where
    mempty = Any False
--exo2
instance Monoid All where
    mempty = All True 
--exo3
instance Monoid Ordering1 where
    mempty = EQ1
--exo4
instance (Monoid a) =>  Monoid (Maybe1 a) where
    mempty = Nothing1
--exo5
instance (Monoid a) => Monoid (First a) where
    mempty = First Nothing
