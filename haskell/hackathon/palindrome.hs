palindrome n = s == reverse s
    where s = (show n)

nums = [100..999]

palindromePairs = [(x,y) | x <- nums, y <- nums, palindrome (x * y)]

maxPair (x1,y1) (x2,y2)
    | x1 + y1 > x2 + y2 = (x1,y1)
    | otherwise = (x2,y2)
    
largest = foldl maxPair (0,0) palindromePairs

main = do
    let x = largest
    putStr "largest is "
    print x
    let y = (fst x) * (snd x)
    putStr "palindrome: "
    print y