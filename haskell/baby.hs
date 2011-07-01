doubleme x = x + x

doubleus x y = doubleme x + doubleme y

x = [13,26..13*24]
y = take 24 [13,26..]
z = take 10 (cycle [1,2,3])
a = take 10 (repeat 5)
b = replicate 3 10
c  = [x*2 | x <- [1..10]] -- list comprehension
cc = [x*2 | x <- [1..10], x*2 >= 12]  -- filtering using predicate
d = [if x < 10 then "Boom!" else "Bang!" | x <- [7..13], odd x]
e = [ x*y | x <- [2,5,10], y <- [8,10,11]]  
f = [1 | _ <- [1..100] ] -- "_": don't care, could use "x" or anything
length' xs = sum [1 | _ <- xs]  
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]   
g = [ [ x | x <- xs, even x ] | xs <- [[1,3,5,2,3,1,2,4,5],[1,2,3,4,5,6,7,8,9],[1,2,4,2,1,6,3,1,3,2,3,6]] ]
h  = zip [1,2,3,4,5] [5,5,5,5,5] 
hh = zip [1..] ["apple", "orange", "cherry", "mango"] 
rightTriangles = [ (a,b,c) | c <- [1..10], b <- [1..c], a <- [1..b], a^2 + b^2 == c^2]

tell :: (Show a) => [a] -> String  
tell [] = "The list is empty"  
tell (x:[]) = "The list has one element: " ++ show x  
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
tell (x:y:_) = "This list is long. The first two elements are: " ++ show x ++ " and " ++ show y

length2 :: (Num b) => [a] -> b  
length2 [] = 0  
length2 (_:xs) = 1 + length' xs

