import Data.List  

solveRPN :: (Num a, Read a) => String -> a  
solveRPN = head . foldl foldingFunction[] . words  
    where 
        foldingFunction (x:y:ys) "*" = (x*y):ys
        foldingFunction (x:y:ys) "+" = (x+y):ys
        foldingFunction (xs) numStr = read numStr:xs
