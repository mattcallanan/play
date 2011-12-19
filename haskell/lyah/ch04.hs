{-
Exercise 1
Define a recursive function mult that takes two positive integers a and b and returns a * b, but only uses addition.
-}

mult a 0 = 0
mult a 1 = a
mult a b = a + (mult a (b-1))


mult' a b
    | a == 0 || b == 0 = 0
	| otherwise = a + (mult a (pred b))

	
mult'' 0 _ = 0
mult'' _ 0 = 0
mult'' a b = a + (a `mult` (b-1))


add' x 0 = x
add' x y = 1 + add' x (y-1)



















{-
Exercise 2
Rewrite the following function using let statements
roots a b c = ((-b + sqrt(b*b - 4*a*c)) / (2*a), (-b - sqrt(b*b - 4*a*c)) / (2*a))
-}
-- Quadratic Equation

--roots a b c = ((-b + sqrt(b*b - 4*a*c)) / (2*a), (-b - sqrt(b*b - 4*a*c)) / (2*a))
roots a b c = let negB = (-b); s = sqrt(b*b - 4*a*c); den = (2*a) in ((negB + s) / den, (negB - s) / den)
rootz a b c = let negB = (-b); s = sqrt(b*b - 4*a*c); den = (2*a); q f = (negB `f` s) / den  in (q (+), q (-))

rooty a b c = let q f = ((-b) `f` sqrt(b*b - 4*a*c)) / (2*a)  in (q (+), q (-))





testRoots 
    | roots 1 3 (-4) == (1.0,-4.0) = putStrLn "Passed"
    | otherwise = error "Failed"

testRootz
    | rootz 1 3 (-4) == (1.0,-4.0) = putStrLn "Passed"
    | otherwise = error "Failed"

testRooty
    | rooty 1 3 (-4) == (1.0,-4.0) = putStrLn "Passed"
    | otherwise = error "Failed"

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
{-
Exercise 3
Using Guards, define a function named sign that takes a single numeric parameter. The function will return 1 if the parameter is positive, -1 if the parameter is negative or 0 otherwise.
-}

sign x
    | x > 0 = 1
    | x < 0 = (-1)
    | otherwise = 0

testSign
    | sign 41 == 1 && sign 0 == 0 && sign (-41) == (-1) = putStrLn "Passed"
    | otherwise = error "Failed"

	
	
	
	
	
{-
Euler Problem 1:
http://projecteuler.net/problem=1

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.
Solve Euler Problem 1 using each of the following language constructs:

Pattern Matching
Guards
Where
Let
Case
-}



-- Pattern
isDiv 0 = True
isDiv _ = False
-- multiple3or5Pattern [x] = True
-- multiple3or5Pattern  _  = False
-- eulerPattern = sum [x | x <- [1..999], multiple3or5Pattern [x | x <- [x], isDiv (x `mod` 3) || isDiv (x `mod` 5)]]
eulerPattern = sum [x | x <- [1..999], isDiv (x `mod` 3) || isDiv (x `mod` 5)]


matchTotal (x:xs) = (if multiple3or5Guard x then x else 0) + matchTotal xs
matchTotal [] = 0
eulerPattern' = matchTotal [1..999]







-- Guard
multiple3or5Guard x
    | x `mod` 3 == 0 = True
    | x `mod` 5 == 0 = True
    | otherwise = False
eulerGuard = sum [x | x <- [1..999], multiple3or5Guard x]






-- Where
eulerWhere = sum [x | x <- [1..999], multiple3or5Where x]
    where multiple3or5Where x = (x `mod` 3 == 0) || (x `mod` 5 == 0)

	
	
	
	
	
	
	
	
	
	
	
-- Let
eulerLet = sum [x | x <- [1..999], let multiple3or5Let x = (x `mod` 3 == 0) || (x `mod` 5 == 0) in multiple3or5Let x]










-- Case
eulerCase = sum [x | x <- [1..999], case [x | x <- [x], multiple3or5Guard x] of [x] -> True
                                                                                _ -> False]


																				
																				
																				
																				
																				
																				
																				
																				
																				
																				
-- TESTS

testEulerPattern
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)
    where expected = 233168
          actual = eulerPattern

testEulerGuard
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)
    where expected = 233168
          actual = eulerGuard

testEulerWhere
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)
    where expected = 233168
          actual = eulerWhere

testEulerLet
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)
    where expected = 233168
          actual = eulerLet

testEulerCase
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)
    where expected = 233168
          actual = eulerCase

