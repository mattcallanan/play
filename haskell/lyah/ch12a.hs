import qualified Data.Monoid as M

foo = do
      x <- Just 1
      y <- Nothing
      return (show x ++ y)



data MyMaybe a = MyNothing | MyJust a deriving (Show, Eq)
instance Monad MyMaybe where
    return x = MyJust x
    MyJust x >>= f = f x

testMyMaybe = ((MyJust 123) >>= (\x -> MyJust (x + 1000))) == (MyJust 1123)

{-
Exercise 1
Given that we have Functors and Applicative Functors, what additional benefit do Monads give us?
-}
{-
Monads let us apply a function that takes a normal value and apply both a transformation and a lift into a context.  It does this by extracting the normal value from a context first.  Helps us bind or chain monadic instances together.
-}

{-
Exercise 2
Monads are Applicative Functors. List all available methods on a Monadic instance.
pure
<*>
<$>
return
>>=
>>
fail
-}

{-
Exercise 3
Given the below functions:

Write the implementations of the lessThanHundred, isEven, withDo and pipeline functions such that:

Any value that is less than a hundred and is even should result in the pipeline function returning Just "complete".
Any value that is either greater than a hundred or odd should result in the pipeline function returning Nothing.
The withDo function should use the "do" syntax and the pipeline method should use monadic functions. Essentially they return the same result but use different syntaxes.

Use the test* functions to verify your individual functions and the testAll function to verify all tests.
-}

lessThanHundred :: Int -> Maybe Int 
lessThanHundred x = if x < 100 then Just x else Nothing

isEven :: Int -> Maybe Int
isEven x = if (even x) then Just x else Nothing


complete :: Maybe String
complete = (return "complete")


valid = 20 :: Int
invalid = 25 :: Int

withDo :: Int -> Maybe String
withDo value = do
               r1 <- lessThanHundred value
               isEven r1
               complete

pipeline :: Int -> Maybe String
pipeline value = return value >>= lessThanHundred >>= isEven >> complete

testValidWithPipeline = pipeline valid == complete
testInvalidWithPipeline = pipeline invalid == Nothing
testValidWithDo = withDo valid == complete
testInvalidWithDo = withDo invalid == Nothing

testAll = (M.getAll $ M.mconcat $ map M.All [testValidWithPipeline, testInvalidWithPipeline, testValidWithDo, testInvalidWithDo]) == True
