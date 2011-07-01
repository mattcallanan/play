-- What Is Functional Programming?
-- Craig Aspinall, 6-Jun-2011

import Control.Monad

multipleOf3 num = mod num 3 == 0

multipleOf5 num = mod num 5 == 0


-- JAVA-LIKE
fizzBuzzOrNumber :: Int -> String
fizzBuzzOrNumber num =
    if multipleOf3 num && multipleOf5 num then "FizzBuzz" else
        if multipleOf3 num then "Fizz" else
            if multipleOf5 num then "Buzz" else
                show num

fizzBuzz :: Int -> [String]                
fizzBuzz a = map fizzBuzzOrNumber [1..a]

main = forM_ (fizzBuzz 100) putStrLn


-- GUARDS

fizzBuzzOrNumberGuard :: Int -> String
fizzBuzzOrNumberGuard num
    | multipleOf3 num && multipleOf5 num = "FizzBuzz"
    | multipleOf3 num = "Fizz"
    | multipleOf5 num = "Buzz"
    | otherwise = show num

fizzBuzzGuard :: Int -> [String]                
fizzBuzzGuard a = map fizzBuzzOrNumberGuard [1..a]

mainGuard = forM_ (fizzBuzzGuard 100) putStrLn


-- RECURSION

fizzBuzzOrNumberRecurse :: [Int] -> [String]
fizzBuzzOrNumberRecurse [] = []
fizzBuzzOrNumberRecurse (num:nums)
    | multipleOf3 num && multipleOf5 num = "FizzBuzz" : (fizzBuzzOrNumberRecurse nums)
    | multipleOf3 num = "Fizz" : (fizzBuzzOrNumberRecurse nums)
    | multipleOf5 num = "Buzz" : (fizzBuzzOrNumberRecurse nums)
    | otherwise = show num : (fizzBuzzOrNumberRecurse nums)
                

fizzBuzzRecurse :: Int -> [String]
fizzBuzzRecurse a = fizzBuzzOrNumberRecurse [1..a]

mainRecurse :: IO ()
mainRecurse = forM_ (fizzBuzzRecurse 100) putStrLn


-- FOLD

fizzBuzzFold :: Int -> [String]
fizzBuzzFold a = foldr (\x acc -> fizzBuzzOrNumberGuard x : acc) [] [1..a]

mainFold :: IO ()
mainFold = forM_ (fizzBuzzFold 100) putStrLn


-- BOOL

-- A Boolean version of mod
modB a b = mod a b == 0

fizzBuzz' x
    | x `modB` 3 && x `modB` 5 = "FizzBuzz"
    | x `modB` 3               = "Fizz"
    | x `modB` 5               = "Buzz"
    | otherwise                = show x

fizzBuzzBool = map fizzBuzz'

mainBool = mapM_ putStrLn $ fizzBuzzBool [1..100]


-- LIST COMPREHENSION

fizzBuzzList upperBound = [fizzBuzzOrNumberGuard num | num <- [1..upperBound]]

mainList = forM_ (fizzBuzzList 100) putStrLn


-- DODGY

--fizzBuzzer :: (Num a, Monad m) => a -> m [Char]
--fizzBuzzer num = do  
--        if multipleOf3 num && multipleOf5 num then return "FizzBuzz" else
--            if multipleOf3 num then return "Fizz" else
--                if multipleOf5 num then return "Buzz" else
--                    return (show num)

--mainDodgy = do
--     colors <- forM [1..100] fizzBuzzOrNumber
--     mapM_ putStrLn colors

