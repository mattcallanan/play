--rep :: ([] a, Num n) => a -> n -> a
repGuard a n
    | n == 0 = a
    | otherwise = a ++ (repGuard a (n-1))

repPattern a 0 = a
repPattern a n = a ++ (repPattern a (n-1))

repIf a n =
    if (n == 0) then a
    else a ++ (repIf a (n-1))
    
repCase a n = 
    case n of
        0 -> a
        otherwise -> a ++ (repCase a (n-1))

