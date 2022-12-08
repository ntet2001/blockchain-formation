--exercise 1 on applicative and Functors Tree Type
data Tree a = EmptyTree | Node a [Tree a] deriving Show

--functor (Here we implement the fmap)
instance Functor  Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node x xs) = Node (f x) (map (fmap f) xs)
     
--Applicative (Here we implement the pure and the <*>)
instance Applicative Tree where 
    pure x = Node x []
    EmptyTree <*> EmptyTree = EmptyTree
    Node f fs <*> EmptyTree = EmptyTree
    EmptyTree <*> Node x xs = EmptyTree
    Node f fs <*> tx@(Node x xs) =  Node (f x) (map (fmap f) xs ++ map (<*> tx) fs)

--exercise 2 Determine if a valid Functor can be written for the datatype
    --1. data Bool = False | True  is not a valid functor because the Kind of a valid Functor is * -> * but
    --2. data BoolAndSomethingElse a = False' a | True' a (a valid Functor)
    --3. data BoolAndMaybeSomethingElse a = Falsish | Truish a (a valid Functor)
    --4. newtype Mu f = InF { outF :: f (Mu f) } (a valid Functor because the Kind is * -> * )
    --data D = D (Array Word Word) Int Int (is not a valid Functor because his kind is * )

--exercise 3
--Rearrange the arguments to the type constructor of the datatype so the Functor instance works
--1. data Sum a b = First b | Second a
-- instance Functor (Sum e) where
-- fmap f (First a) = First (f a)
-- fmap f (Second b) = Second b

--2. data Company a b c = DeepBlue a b | Something c
--instance Functor (Company e e') where
--fmap f (Something b) = Something (f b)
--fmap _ (DeepBlue a c) = DeepBlue a c

--3. data More a b = L b a b | R a b a deriving (Eq, Show)
--instance Functor (More x) where
--fmap f (L a b a') = L (f a) b (f a')
--fmap f (R b a b') = R b (f a) b'

--exercise 4
data Quant a b = Finance | Desk a | Bloor b 
instance Functor (Quant x) where
    fmap f Finance = Finance
    fmap f (Desk a) = Desk a 
    fmap f (Bloor b) = Bloor (f b)

newtype K a b = K a
instance Functor (K a) where
    fmap f (K x) = K x

newtype Flip f a b = Flip (f b a) deriving (Eq, Show)
instance Functor (Flip K x) where
    fmap g (Flip (K x)) = Flip (K (g x)) 

newtype EvilGoateeConst a b = GoatyConst b
instance Functor (EvilGoateeConst a) where
    fmap f (GoatyConst x) = GoatyConst (f x)

newtype LiftItOut f a = LiftItOut (f a)
instance (Functor f) => Functor (LiftItOut f) where
    fmap g (LiftItOut f) = LiftItOut (fmap g f) 

data Parappa f g a = DaWrappa (f a) (g a)
instance (Functor f , Functor g) => Functor (Parappa f g) where
    fmap h  (DaWrappa f g) = DaWrappa (fmap h f) (fmap h g)

data IgnoreOne f g a b = IgnoringSomething (f a) (g b)
instance (Functor f , Functor g) => Functor (IgnoreOne f g a) where
    fmap h (IgnoringSomething f g) = IgnoringSomething f (fmap h g)

data Notorious g o a t = Notorious (g o) (g a) (g t)
instance (Functor g) => Functor  (Notorious g o a) where
    fmap f (Notorious g h i) = Notorious g h (fmap f i)

data List a = Nil | Cons a (List a)
instance Functor List where
    fmap f Nil = Nil
    fmap f  (Cons x g) = Cons (f x) (fmap f g)

data GoatLord a = NoGoat | OneGoat a | MoreGoats (GoatLord a) (GoatLord a) (GoatLord a)
instance Functor GoatLord where
    fmap f NoGoat = NoGoat
    fmap f (OneGoat x) = OneGoat (f x)
    fmap f (MoreGoats g h i) = MoreGoats (fmap f g) (fmap f h) (fmap f i)

data TalkToMe a = Halt | Print String a | Read (String -> a)