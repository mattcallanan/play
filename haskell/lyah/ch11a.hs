import Control.Applicative

{- ### Exercise 1
    * What are Functors useful for?
    * What's the difference between fmap and (.) ?
-}
-- Nothing.  Functions can act as Functors.  Partially applied functions are written as (-> r) which has the type * -> *.  fmap can be applied to a partially applied function like this:
-- fmap (+100) (*4)
-- This lifts (+100) into the (-> r) Functor and applies it to the Functor (*4) resulting effectively in (+100) . (*4)


{- ### Exercise 2
Demonstrate using an IO action as a Functor.
-}
ioFunctory = fmap (cycle) getLine >>= putStrLn
                 

{- ### Exercise 3
Make the following Tree type an instance of Applicative:

     data Tree a = Node (Tree a) (Tree a) | Leaf a deriving Show

Prove that it follows the two Functor laws.
-}
data Tree a = Node (Tree a) (Tree a) | Leaf a deriving (Show, Eq)

instance Functor Tree where
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node x y) = Node (fmap f x) (fmap f y)

testFmap = (fmap (+1000) $ Node (Leaf 100) (Leaf 200)) == (Node (Leaf 1100) (Leaf 1200))
testIdLaw = (fmap id $ Node (Leaf 100) (Leaf 200)) == (Node (Leaf 100) (Leaf 200))
testComposeLaw = (fmap id $ Node (Leaf 100) (Leaf 200)) == (Node (Leaf 100) (Leaf 200))


