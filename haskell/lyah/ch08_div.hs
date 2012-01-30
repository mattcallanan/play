{-
fifties  = filter ((==) 0 . flip mod 50) [20,30..1000]
doIt = foldr currPairs [] [20,30..1000]
    where currPairs x pairs = currPair x : pairs
          currPair 30 = Nothing
          currPair x = if x `elem` fifties then Just (x, (0, x `div` 50)) else Just (x, (f x))
                       where f x = if x `mod` 50 `mod` 20 == 0 
                                   then (x `mod` 50 `div` 20, x `div` 50) 
                                   else ((x - ((g x) * 50)) `div` 20, g x)
                             g x = (x `div` 50) - 1
-}
                             
data CurrencySupply2 = CurrencySupply2 {twenties :: Integer, fifties :: Integer} deriving (Eq, Ord)
instance Show CurrencySupply2 where
    show c = show (twenties c) ++ " * $20, " ++ show (fifties c) ++ " * $50: $" ++ show (twenties c * fifties c)

genCombs = foldr currSupps [] [20,30..1000]
    where currSupps x pairs = currSupp x : pairs
          currSupp 30 = Nothing
          currSupp x = if x `elem` fifties then Just (CurrencySupply2 0 (x `div` 50)) else Just (f x)
                       where fifties = filter ((==) 0 . flip mod 50) [20,30..1000]
                             f x = if x `mod` 50 `mod` 20 == 0 
                                   then (CurrencySupply2 (x `mod` 50 `div` 20) (x `div` 50))
                                   else (CurrencySupply2 ((x - ((g x) * 50)) `div` 20) (g x))
                             g x = (x `div` 50) - 1

