import Data.Monoid

{-    
Chapter 12 Question
Given:
-}

data CurrencySupply2 = CurrencySupply2 {twenties :: Integer, fifties :: Integer} deriving (Eq, Ord, Show)

maybeSupplies = foldr currSupps [] [20,30..1000]
    where currSupps x supps = currSupp x : supps
          currSupp 30 = Nothing
          currSupp x = if x `elem` fifties then Just (CurrencySupply2 0 (x `div` 50)) else Just (f x)
                       where fifties = filter ((==) 0 . flip mod 50) [20,30..1000]
                             f x = if x `mod` 50 `mod` 20 == 0 
                                   then (CurrencySupply2 (x `mod` 50 `div` 20) (x `div` 50))
                                   else (CurrencySupply2 ((x - ((g x) * 50)) `div` 20) (g x))
                             g x = (x `div` 50) - 1
definiteSupplies = [x | (Just x) <- maybeSupplies]

{-
Make CurrencySupply2 a Monoid such that the following tests pass:
-}
instance Monoid CurrencySupply2 where
    mempty = CurrencySupply2 0 0
    (CurrencySupply2 t1 f1) `mappend` (CurrencySupply2 t2 f2) = (CurrencySupply2 (t1 + t2) (f1 + f2))


testMconcatDefiniteSupplies = mconcat definiteSupplies == CurrencySupply2 193 932
testMconcatMaybeSupplies = mconcat maybeSupplies == Just (CurrencySupply2 193 932)





{-
make your CurrencySupplyTree an instance of Foldable
foldMap valueCS2 buildTree
-}
