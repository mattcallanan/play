chain n
    | n == 1 = [1]
	| even n = n:chain (n `div` 2)
	| otherwise = n:chain (n*3+1)