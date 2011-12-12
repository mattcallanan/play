nouns = ["hobo","frog","pope"]
adjectives = ["lazy","grouchy","scheming"]  
epicHilarity = [adjective ++ " " ++ noun | adjective <- adjectives, noun <- nouns] 

{-Exercises:-}
-- Rewrite the following with the use of the notElem (not an element of) function:
-- [x | x <- [10..20], x /= 13, x /= 15, x /=19]
ex1 = [x | x <- [10..20], x `notElem` [13, 15, 19] ]


-- Write the replicate function, in terms of repeat and take. Eg:
-- replicate 3 10 == ??
ex2 = take 3 (repeat 10)

-- Write the sum of the numbers in each sublist of xxs without flattening it:
-- let xxs = [ [1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6] ]
-- Eg: [ [x], [y], [z] ], where x,y,z are totals.
xxs = [ [1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6] ]
ex3 = [[xs] | xs <- map sum xxs ]

-- What is the type of the tuple in the following expression:
-- ([1,2,3], "hello", ['a','b'], (1, 'c', True))
-- Eg. (True, 'a') is a (Bool, Char)

-- Answer: ([Num], [Char], [Char], (Num, Char, Bool))
