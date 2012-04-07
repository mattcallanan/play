multipleOf3or5 n = n `mod` 3 == 0 || n `mod` 5 == 0

eulerList :: [Integer]
eulerList = filter multipleOf3or5 [1..999]

--euler = sum eulerList
euler = foldl (+) 0 eulerList
