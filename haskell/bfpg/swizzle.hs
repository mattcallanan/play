x = "whatever"
-- y = x + 3

swazzle :: Int -> Int
swazzle swaggle = 
    swaggle + 8

{-
rep :: ([] a, Num n) => a -> n -> a
rep a n = a ++ (rep a n-1)
rep a 0 = a
-}

rev :: (Num a) => [a] -> [a]
rev [] = []                               -- nil case
rev (h:t) = rev t ++ [h]                  -- cons case


revX acc [] = acc
revX acc (h:t) = revX (h:acc) t

rev2 x = revX [] x
rev3 = revX []


-- Read in two files and reverse
bind = 
    readFile "../passwd.txt" 
    >>=                               -- bind :: Monad m => m a -> (a -> m b) -> m b
    \p ->                             -- p = contents of passwd.txt
    readFile "swizzle.hs"             -- IO String  (IO is Monad)
    >>=                               -- bind
    \g ->                             -- g = contents of swizzle.hs
    return (rev2 p ++ rev2 g)

bind2 =
    do p <- readFile "../passwd.txt"
       g <- readFile "swizzle.hs"
       return (rev2 p ++ rev2 g)
       
-- "<-" = Monad comprehension e.g. LINQ from, select... Scala for comprehension

-- :m + Data.Char
y = fmap (map toUpper) bind
