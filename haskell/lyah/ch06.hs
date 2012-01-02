	{-
1. Without looking in prelude define the higher-order library function "curry" that converts a function on pairs into a curried function, and, conversely, the function uncurry that converts curried function with two arguments into a function on pairs.
When would you use these functions?
-}

curry' :: ((a,b) -> c) -> (a -> b -> c)
curry' f = g
    where g x y = f (x,y)

uncurry' :: (a -> b -> c) -> ((a,b) -> c)
uncurry' f = g
    where g (x,y) = f x y
	
-- Tests	
--(curry' fst) 11 22 == 11
--(curry' snd) 11 22 == 22
--(uncurry' (+)) (12,23) == 35

-- When would you use these functions?

{-
2. Rewrite [f x | x <- xs, p x] using map and filter
-}

prob02 :: (a -> b) -> (a -> Bool) -> [a] -> [b]
prob02 f p xs = [f x | x <- xs, p x]

--prob02' :: (a -> b) -> (a -> Bool) -> [a] -> [b]
prob02' f p xs = filter p $ map f xs

--Tests
--prob02' (truncate . (/10)) (\x -> x `mod` 10 == 0) [100,110,200,210] == [10,20]

{-
3. Implement the following functions using what you have learnt in the chapter. Try to make them as short and readable as possible.

length' :: [b] -> Integer
append' :: [a] -> [a] -> [a]
flatten' :: [[a]] -> [a]
flatmap' :: (a -> [b]) -> [a] -> [b]
-}

length' :: [b] -> Integer
length' = foldr (\_ -> (+1)) 0

append' :: [a] -> [a] -> [a]
append' xs ys = foldl (\acc x -> acc++[x]) xs ys

flatten' :: [[a]] -> [a]
flatten' = foldr1 (++)

flatmap' :: (a -> [b]) -> [a] -> [b]
flatmap'  f xs = foldr1 (++) $ map f xs
flatmap'' f = scanr1 (\x acc -> (f x) ++ acc)

-- Tests
-- flatmap' (replicate 3) [1..4] == [1,1,1,2,2,2,3,3,3,4,4,4]

{-
4. Using folds, define a function
dec2nat :: [Int ] -> Int 
that converts a decimal number into a natural number
	eg. dec2nat [2, 3, 4, 5] = 2345
(foldl, lambdas)
-}

dec2nat :: [Int] -> Int
dec2nat xs = foldl1 (\acc x -> acc * 10 + x) xs
dec2nat' xs = foldl1 ((+) . (*10)) xs

-- Tests
-- dec2nat [2, 3, 4, 5] == 2345

{-
5. Rewrite this simple fibonacci function using scans
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
(hint: infinite lists and recursion)
-}

fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
fib' 0 = 0
fib' 1 = 1
fib' n = scanl (\acc x -> fib x) 0 [0..n]

-- Tests
-- fib' 10 == [0,1,1,2,3,5,8,13,21,34,55]


{-
6. Convert the following to point free style:
	f x = 5 + 8/x
-}

prob06 = (+5) . (8`div`)

-- Tests
-- prob06 2 == 9
-- prob06 4 == 7


{-
7. Express fst & snd using curry or uncurry and other Prelude functions (don't use lambdas)
-}

fst' :: (a, b) -> a
fst' = uncurry const
snd' :: (a, b) -> b
snd' = uncurry $ flip const


--curry   :: ((a, b) -> c) -> a -> b -> c
--uncurry :: (a -> b -> c) -> (a, b) -> c

