import Control.Applicative

{- ### Exercise 1
    * What's the difference between Functors and Applicative Functors ?
    * What's the difference between $ and <$> ?
-}

{- ### Exercise 2
    Demonstrate using an IO action as an Applicative Functor.
-}

{- ### Exercise 3
    Make the following Tree type an instance of Applicative:
        data Tree a = Node (Tree a) (Tree a) | Leaf a deriving (Show, Eq)
-}

data Tree a = Node (Tree a) (Tree a) | Leaf a deriving (Show, Eq)
instance Functor Tree where
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node x y) = Node (fmap f x) (fmap f y)
instance Applicative Tree where
    pure = Leaf
    Leaf f <*> Leaf x = Leaf (f x)
    Leaf f <*> Node l r = Node (fmap f l) (fmap f r)
    Node fl fr <*> Node l r = Node (Node (fl <*> l) (fl <*> r)) (Node (fr <*> l) (fr <*> r))


testPure = pure 100 == Leaf 100
--testPure2 = (pure (+200)) == (Leaf (+200))
{-
    No instance for (Eq (a0 -> a0))
      arising from a use of `=='
    Possible fix: add an instance declaration for (Eq (a0 -> a0))
    In the expression: (pure (+ 200)) == (Leaf (+ 200))
    In an equation for `testPure2':
        testPure2 = (pure (+ 200)) == (Leaf (+ 200))
-}

testStarship = (Leaf (+1000) <*> Node (Leaf 100) (Leaf 200)) == (Node (Leaf 1100) (Leaf 1200))
testStarship2 = ((Node (Leaf (+1000)) (Leaf (+2000))) <*> Node (Leaf 100) (Leaf 200)) == Node (Node (Leaf 1100) (Leaf 1200)) (Node (Leaf 2100) (Leaf 2200))

add200 = pure (+200) :: Num a => Tree (a -> a)
testStarship3 = (add200 <*> (Leaf 500)) == (Leaf 700)

testPureFmapLaw = (pure f <*> x) == fmap f x 
                  where f = (*20)
                        x = Leaf 3

--testLiftA2 = liftA2 (+) (Leaf 100) (Leaf 3000) == (Leaf 3100)
testLiftA = liftA (+2000) (Leaf 100)  == ((+2000) <$> (Leaf 100))
testLiftA2 = liftA2 (+) (Leaf 100) (Leaf 3000) == ((+) <$> (Leaf 100) <*> (Leaf 3000))


testFmap = (fmap (+1000) $ Node (Leaf 100) (Leaf 200)) == (Node (Leaf 1100) (Leaf 1200))
testIdLaw = (fmap id $ Node (Leaf 100) (Leaf 200)) == (Node (Leaf 100) (Leaf 200))


                      
{- ### Exercise 4
    Write calcTax, a function that takes 2 Maybes, the first Maybe contains an amount, the second contains a taxation function. Return a Maybe with the result of applying the taxation function to the value.

        testCalcTax = calcTax (Just 1000.00) (Just (/10)) == Just 100.00
        
    Then write applyTax, same signatures as calcTax but returns the result of subtracting the taxation from the input amount.
    
		testApplyTax = applyTax (Just 1000.00) (Just (/10)) == Just 900.00
-}

calcTax :: Maybe Float -> Maybe (Float -> Float) -> Maybe Float
calcTax v t = t <*> v

applyTax :: Maybe Float -> Maybe (Float -> Float) -> Maybe Float
applyTax v t = (-) <$> v <*> calcTax v t

testCalcTax = calcTax (Just 1000.00) (Just (/10)) == Just 100.00
testApplyTax = applyTax (Just 1000.00) (Just (/10)) == Just 900.00


{- ### Exercise 5
    Using 1) pure, 2) fmap, and 3) <$> write 3 Applicative alternatives to the following function:
    concat :: Maybe String -> Maybe String -> Maybe String
    concat (Just x) (Just y) = Just (x ++ y)

    Test functions:
    ---------------
    testConcatPure   = concatPure (Just "Yes") (Just "No") == (Just "YesNo")
    testConcatFmap   = concatFmap (Just "Yes") (Just "No") == (Just "YesNo")
    testConcatDollar = concatDollar (Just "Yes") (Just "No") == (Just "YesNo")
-}

concat :: Maybe String -> Maybe String -> Maybe String
concat (Just x) (Just y) = Just (x ++ y)

concatPure x y = pure (++) <*> x <*> y
concatFmap x y = fmap (++) x <*> y
concatDollar x y = (++) <$> x <*> y

testConcatPure   = concatPure (Just "Yes") (Just "No") == (Just "YesNo")
testConcatFmap   = concatFmap (Just "Yes") (Just "No") == (Just "YesNo")
testConcatDollar = concatDollar (Just "Yes") (Just "No") == (Just "YesNo")
