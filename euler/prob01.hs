{-Problem 1
05 October 2001

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
-}

multiple3or5 x = (x `mod` 3 == 0) || (x `mod` 5 == 0)
threesAndFives max = [x | x <- [1..max], (x `mod` 3) == 0 || (x `mod` 5) == 0]
sumThreesAndFives max = sum items


-- http://projecteuler.net/thread=1
prob01b = sum [3,6..999] + sum [5,10..999] - sum [15,30..999]  

