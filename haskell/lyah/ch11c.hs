import Control.Applicative
import Data.Monoid
import qualified Data.Foldable as F

{- ### Exercise 1
    You just started working for Dodgy Bros Inc. They've asked you to write DodgyList, which is a list in every respect except the implementation of Functor will be rewritten to always return [].
    Use this test (you'll need "deriving (Eq)" for your DodgyList):
        testDodgy = (fmap (+100) (DodgyList [1..10])) == (DodgyList [])
-}
newtype DodgyList a = DodgyList [a] deriving (Eq)
instance Functor DodgyList where
    fmap f _ = DodgyList []

testDodgy = (fmap (+100) (DodgyList [1..10])) == (DodgyList [])

{- ### Exercise 2
    Make the following Tree type an instance of Monoid where the contents of the tree are an instantce of Monoid:
        data Tree a = Empty | Node (Tree a) (Tree a) | Leaf a deriving (Show, Eq)
    To get you started:
        instance Monoid a => Monoid (Tree a) where
-}

type Id = Integer
data Customer = Customer {id :: Id, firstName :: String, surname :: String, postCode :: Integer}
type CustMap = [(Id, Customer)]

data Any = Any { getAny :: Bool } deriving Show

data Tree a = Empty | Node (Tree a) (Tree a) | Leaf a deriving (Show, Eq)
instance Monoid a => Monoid (Tree a) where
    mempty = Empty
    x `mappend` Empty = x
    Empty `mappend` x = x
    (Leaf x) `mappend` (Leaf y) = Leaf (x `mappend` y)
    (Leaf x) `mappend` (Node l r) = Leaf (x) `mappend` (l `mappend` r)
    (Node l r) `mappend` (Leaf x) =  (l `mappend` r) `mappend` Leaf (x)
    (Node l1 r1) `mappend` (Node l2 r2) = l1 `mappend` r1 `mappend` l2 `mappend` r2
--    (Leaf m) `mappend` (Node l r) = Leaf (m1 `mappend` m2)

testM1 = (Leaf (Sum 100)) `mappend` (Leaf (Sum 200)) == Leaf (Sum 300)
testM2 = (Node (Leaf (Sum 100)) (Leaf (Sum 200))) `mappend` (Node (Leaf (Sum 1000)) (Leaf (Sum 2000))) == Leaf (Sum 3300)

    
{- ### Exercise 3
    Now make the tree an instance of Foldable.
-}

instance F.Foldable Tree where
--    foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m  
    foldMap f Empty = mempty
    foldMap f (Leaf x) = f x
    foldMap f (Node l r) = F.foldMap f l `mappend` F.foldMap f r


node1 = (Node (Leaf 100) (Leaf 200))
node2 = (Node (Leaf 1000) (Leaf 2000))
testF1 = F.foldMap Sum (Leaf 100) == Sum 100
testF2 = F.foldMap Sum node1 == Sum 300
testF3 = F.foldMap Sum (Node node1 node2) == Sum 3300
