import Control.Monad
import Data.Monoid
import Control.Monad.Writer


--logNumber :: Int -> Writer [String] Int  
--logNumber x = Writer (x, ["Got number: " ++ show x])  

newtype MyWriter w a = MyWriter { runMyWriter :: (a, w) }  
instance (Monoid w) => Monad (MyWriter w) where  
    return x = MyWriter (x, mempty)  
    (MyWriter (x,v)) >>= f = let (MyWriter (y, v')) = f x in MyWriter (y, v `mappend` v')


{-
### Exercise 1
Write a simple program that iterates through a List and uses the WriterMonad to log the progress of each item within the list. Add the word: "Complete" to the end of your log once the List has been traversed.
Use the following function definition as a starting point if desired:
    count :: (Show a) => [a] -> Writer [String] ()

An example run with: count [1..10] would look like:
    runWriter $ count [1..10]
    ((),["value: 1","value: 2","value: 3","value: 4","value: 5","value: 6","value: 7","value: 8","value: 9","value: 10","Complete"])
-}

{- Not in scope: data constructor `Writer' -}

--count1 :: (Show a) => [a] -> Writer [String] ()
---count1 [] =  writer ((), ["Complete"])
--count1 (x:xs) = writer ((), strings)
--    where (_, y) = runWriter $ count1 xs
--          strings = ("value: " ++ show x) : y

count :: (Show a) => [a] -> MyWriter [String] ()
count [] =  MyWriter ((), ["Complete"])
count (x:xs) = MyWriter ((), strings)
    where MyWriter (_, y) = count xs
          strings = ("value: " ++ show x) : y

--countSanj [] = writer ((), ["Complete"])
--countSanj (x:xs) = writer ((), [("value: " ++ show x) >>= (\_ -> countSanj xs)]          

--countAndrew = (\x -> badCount x)
--badCount :: (Show a) => [a] -> MyWriter [String] ()
--badCount x = do
--    mapM_ (\a -> tell ["value: " ++ show x]) x
--    tell ["Complete"]

countSteve x = mapM_ (\y -> writer ((), [("value: " ++ show y)])) x >> tell ["Complete"]


testCount = (runMyWriter $ count [1..10]) == ((),["value: 1","value: 2","value: 3","value: 4","value: 5","value: 6","value: 7","value: 8","value: 9","value: 10","Complete"])

{-
### Exercise 2

Using java.lang.StringBuilder as an example, create a "Buffer" instance of Monad. Create an append function
such that:
   testAppend1 = (return "abc" >>= append "123" >>= append "xyz") == (Buffer "abc123xyz")
   testAppend2 = (return [1,1,1] >>= append [2,2,2] >>= append [3,3,3]) == (Buffer [1,1,1,2,2,2,3,3,3])

  Make sure your Buffer instance adheres to the Monad laws.
  What is the context maintained by this Monad?
  Discuss whether this valid Monadic instance or just an instance of another well-known Monad.

_hint_ you may have to make your structure polymorphic unlike StringBuilder.
-}

data Buffer a = Buffer a deriving (Show, Eq)
instance Monad Buffer where
    return x = Buffer x
    Buffer s >>= f = f s

append :: (Monoid a) => a -> a -> Buffer a
--append suffix orig = Buffer (orig ++ suffix)
append suffix orig = Buffer (orig `mappend` suffix)

testAppend = (return "abc" >>= append "123" >>= append "xyz") == (Buffer "abc123xyz")
testAppend2 = (return [1,1,1] >>= append [2,2,2] >>= append [3,3,3]) == (Buffer [1,1,1,2,2,2,3,3,3])
testAll = (Data.Monoid.getAll $ Data.Monoid.mconcat $ map Data.Monoid.All [testAppend, testAppend2]) == True

{-
newtype Buffer2 a = Buffer2 [a]
instance Monad Buffer2 where
    return x = Buffer2 [x]
    Buffer2 xs >>= f = \y -> Buffer2 (y:xs)
        where Buffer2 ys = xs `mappend` ys

-}
