{- Euler Problem 2
19 October 2001

Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.
-}

-- ANSWER: 4613732
-- http://projecteuler.net/thread=2

fib 1 = 1
fib 2 = 2
fib n = (fib (n-1)) + (fib (n-2))
prob02 = sum . takeWhile (<=4000000) . filter even $ (map fib [1..])

          
prob02' = sum $ filter even $ takeWhile (<4000000) fibs'
fibs' = scanl (\acc x -> fib x) 1 [3..]
    where fib 0 = 0
          fib 1 = 1
          fib n = fib (n-1) + fib (n-2)


          
          
--fib :: Int -> [Int] -> [Int]
--fib max [] = 1
--fib max [1] = [1,2]
--fib max xs = [rest++[sndlst,lst,(lst+sndlst)] | [lst:sndlst:rest] <- reverse xs]
--addFirstTwo (x:y:xs) = x + y
--fib xs = if ((last xs) > 4000000) then [] else fib(xs ++ [addFirstTwo (reverse xs)])
fibOrig xs = if ((last xs) > 4000000) then (init(xs)) else fibOrig(xs ++ [(last xs) + last(init xs)])
prob02Orig = sum [x | x <- fibOrig [1,2], even x]

--http://stackoverflow.com/questions/2404156/understanding-haskells-fibonacci
fibs = 1 : 2 : [ a + b | (a, b) <- zip fibs (tail fibs)]
prob02b = sum $ filter even (takeWhile (< 4000000) fibs)


-- Find the last but one element of a list
-- http://haskell.org/haskellwiki/99_questions/Solutions/2
myButLast :: [a] -> a
myButLast = last . init
 
myButLast' x = reverse x !! 1
 
myButLast'' [x,_]  = x
myButLast'' (_:xs) = myButLast'' xs
 
myButLast''' (x:(_:[])) = x
myButLast''' (_:xs) = myButLast''' xs
 
myButLast'''' = head . tail . reverse