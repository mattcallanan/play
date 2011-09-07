import System.IO
import Data.List.Split

-- Geoff's orig
mainOrig = do
  customers <- readFile "customers.csv"
  blacklist <- readFile "blacklist.csv"
  let cs = lines customers
  let h = head cs
  let bs = lines blacklist
  writeFile "output.csv" (unlines (h:(filter (`notBlacklisted` bs) cs)))


mainBind = readFile "customers.csv" >>= 
  \customers -> readFile "blacklist.csv" >>=
  \blacklist -> writeFile "output.csv" (unlines ((head (lines customers)):(filter (`notBlacklisted` (lines blacklist)) (lines customers))))


mainLet       = readFile "customers.csv" >>= 
  \customers -> readFile "blacklist.csv" >>=
  \blacklist -> let cs = lines customers
             in let  h = head cs
             in let bs = lines blacklist
             in writeFile "output.csv" (unlines (h:(filter (`notBlacklisted` bs) cs)))

-- Doesn't work!
{-
mainLet = readFile "customers.csv" >>= 
  \customers -> readFile "blacklist.csv" >>=
  \blacklist ->   
  let cs = lines customers
  let h = head cs
  let bs = lines blacklist
  writeFile "output.csv" (unlines (h:(filter (`notBlacklisted` bs) cs)))
-}

-- Doesn't work!
{-
mainWhere = readFile "customers.csv" >>= 
  \customers -> readFile "blacklist.csv" >>=
  \blacklist ->  writeFile "output.csv" (unlines (h:(filter (`notBlacklisted` bs) cs)))
  where cs = lines customers
        h = head cs
        bs = lines blacklist
-}

notBlacklisted c bs = p `notElem` bs
  where parts = splitOn "," c
        p     = head (drop 5 parts)
