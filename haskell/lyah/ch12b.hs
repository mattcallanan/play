import Control.Monad (Monad, (>>=), guard)
import Data.Monoid

{-
Exercise 1

Write the following list comprehension in Monadic do notation:

[(x*x) | x <- [1..50], '7' `elem` show x, x > 20]
verify that the results produced are equal to:

results = [729,1369,2209]
hint: MonadPlus and Guards.
-}
ex1 = do  
      x <- [1..50]  
      guard ('7' `elem` show x)
      guard (x > 20)
      return (x*x)
      
{-
Exercise 2

Write the list comprehension given in question 1 in terms of >>= and >>.
-}
ex2 = [1..50] >>= \x -> 
          guard ('7' `elem` show x) >> 
              --return x >>= \x -> 
                  guard (x > 20) >> 
                      return (x*x)

{-
Exercise 3

Given the definition of <=<, prove the 3 monad laws apply to <=<:

import Control.Monad (Monad, (>>=))
(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = (\x -> g x >>= f)

If you have issues using the <=< function, feel free to rename it.

1. Left Identity: return x >>= f == f x
2. Right Identity: m >>= return is no different than just m
3. Associativity: (m >>= f) >>= g is just like doing m >>= (\x -> f x >>= g)
-}
(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = (\x -> g x >>= f)

leftId f = return <=< f
rightId f = f <=< return
assoc1 f g h = f <=< (g <=< h)
assoc2 f g h = (f <=< g) <=< h
fn = (\x -> [x,-x])
fn1 = (\x -> [x+10])
fn2 = (\x -> [x+100])
fn3 = (\x -> [x+1000])
testLeftId = leftId fn 10 == (fn 10)
testRightId = rightId fn 10 == (fn 10)
testAssoc = (assoc1 fn1 fn2 fn3 3) == (assoc2 fn1 fn2 fn3 3)


--data (Monoid a) => Buffer a = Buffer a deriving (Show, Eq)
data Buffer a = Buffer a deriving (Show, Eq)
instance Monad Buffer where
    return x = Buffer x
    Buffer s >>= f = f s

append :: [a] -> [a] -> Buffer [a]
append suffix orig = Buffer (orig `mappend` suffix)

testAppend = (return "abc" >>= append "123" >>= append "xyz") == (Buffer "abc123xyz")
testAppend2 = (return [1,1,1] >>= append [2,2,2] >>= append [3,3,3]) == (Buffer [1,1,1,2,2,2,3,3,3])
testAll = (Data.Monoid.getAll $ Data.Monoid.mconcat $ map Data.Monoid.All [testAppend, testAppend2]) == True
