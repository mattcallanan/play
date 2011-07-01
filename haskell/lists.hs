
countRight :: [a] -> Int -> Int
countRight xs n = length xs + n

countLeft :: Int -> [a] -> Int
countLeft n xs = length xs + n

foldRight :: (a -> b -> b) -> b -> [a] -> b
foldRight f acc []     = acc
foldRight f acc (x:xs) = f x (foldRight f acc xs)

foldLeft  :: (a -> b -> a) -> a -> [b] -> a
foldLeft f acc []     =  acc
foldLeft f acc (x:xs) =  foldLeft f (f acc x) xs

-- http://en.wikibooks.org/wiki/Haskell/Print_version
addStr :: String -> Float -> Float
addStr str x = read str + x

sumStr :: [String] -> Float
sumStr = foldr addStr 0.0
