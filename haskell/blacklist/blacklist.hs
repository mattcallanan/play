customers = readFile "customers.csv"
blacklist = readFile "blacklist.csv"

blacklisted :: String -> [String] -> Bool
blacklisted c bs = contains bs c

process :: String -> String -> String
process cs bs = join [ x | x -> (splitOn "\n" cs), (!blacklisted x (splitOn "\n" bs) ] "\n"

main =
    do cs <- readFile "customers.csv"
       bs <- readFile "blacklist.csv"
       return (writeFile "output.csv" $ process cs bs)


{-
> cabal install split
> ghci blacklist.hs
*Main> :m + Data.List.Split

*Main Data.List.Split> splitOn "\n" customers

<interactive>:1:14:
    Couldn't match expected type
    `[Char]' with actual type `IO String'
    In the second argument of `splitOn', namely `customers'
    In the expression: splitOn "\n" customers
    In an equation for `it': it = splitOn "\n" customers

*Main Data.List.Split> :t readFile
readFile :: FilePath -> IO String
*Main Data.List.Split> :t splitOn
splitOn :: Eq a => [a] -> [a] -> [[a]]

http://osdir.com/ml/lang.haskell.general/2002-11/msg00090.html

-}
