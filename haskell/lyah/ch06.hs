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

-- When would you use these functions?

{-
2. Rewrite [f x | x <- xs, p x] using map and filter
-}

prob2 :: (a -> a) -> (a -> Bool) -> [a] -> [a]
--prob2  f p xs = [f x | x <- xs, p x]
--prob2 f p xs = map f $ filter p xs
--prob2 f p = map f . filter p
--prob2 f = map f . filter
prob2 = (. filter) . (.) . map


{-
3. Implement the following functions using what you have learnt in the chapter. Try to make them as short and readable as possible.

length' :: [b] -> Integer
append' :: [a] -> [a] -> [a]
flatten' :: [[a]] -> [a]
flatmap' :: (a -> [b]) -> [a] -> [b]
-}

length' :: [b] -> Integer
--length' = foldr (\_ -> (+1)) 0
--length' (x:xs) = foldr (+1) 1 xs
length' = foldl (const . succ) 0

append' :: [a] -> [a] -> [a]
--append' xs ys = foldl (\acc x -> acc++[x]) xs ys
--append' xs ys = foldr (:) ys xs
append' = flip (foldr (:))

flatten' :: [[a]] -> [a]
flatten' = foldr1 (++)

--flatmap' :: (a -> [b]) -> [a] -> [b]
--flatmap'  f = foldr1 (++) $ map f
--flatmap'' f = scanr1 (\x acc -> (f x) ++ acc)


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
--dec2natEd xs = foldl (lacc (a,b) ->acc + a * b) - decs
--    where decs = zip (map (10^)
--dec2natSanj [] = 0
--dec2natSanj xs = read . foldl (\a v -> a++ show v) "" xs


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
fib' 0 = [0]
fib' 1 = [1]
fib' n = scanl (\acc x -> fib x) 0 [0..n]
fib'' n = fibS [0..n]
fibS [] = []
fibS [0] = [0]
fibS [1] = [0,1]
--fibS xs = scanl (\acc x -> x:(fibS acc)) [] xs
fibsEd = 1 : scanl (+) 1 fibsEd
fibsSteve = scanl (+) 0 (1:fibsSteve)

{-
6. Convert the following to point free style:
	f x = 5 + 8/x
-}

prob6 = (+5) . (8`div`)


{-
7. Express fst & snd using curry or uncurry and other Prelude functions (don't use lambdas)
-}

fst' :: (a, b) -> a
fst' = uncurry const
snd' :: (a, b) -> b
snd' = uncurry $ flip const
snd'' = uncurry seq

--curry   :: ((a, b) -> c) -> a -> b -> c
--uncurry :: (a -> b -> c) -> (a, b) -> c



-- Tests	
testProb1Curry   = (curry' fst) 11 22 == 11
testProb1Uncurry = (uncurry' (+)) (12,23) == 35
--testProb2        = prob2 (truncate . (/10)) (\x -> x `mod` 10 == 0) [100,110,200,210] == [10,20]
testProb2        = prob2 (+11) odd [1..10] == [x+11 | x <- [1..10], odd x] --[12,14,16,18,20]
testProb3Length  = length' [1..10] == 10
testProb3Append  = append' "has" "kell" == "haskell"
testProb3Flatten = flatten' ["abc","def","ghi"] == "abcdefghi"
--testProb3Flatmap = flatmap' (replicate 3) [1..4] == [1,1,1,2,2,2,3,3,3,4,4,4]
testProb4        = dec2nat [2, 3, 4, 5] == 2345
testProb5        = fib' 10 == [0,1,1,2,3,5,8,13,21,34,55]
testProb6        = prob6 2 == 9
testProb7Fst     = fst' (1,2) == 1
testProb7Snd     = snd' (1,2) == 2
