import System.IO
import Data.List.Split

main = do
  -- read the file contents
  customers <- readFile "customers.csv"
  blacklist <- readFile "blacklist.csv"

  -- Split the files into lists and save the header
  let cs = lines customers
  let h = head cs
  let bs = lines blacklist

  writeFile "output.csv" (unlines (h:(filter (`notBlacklisted` bs) cs)))

notBlacklisted c bs = p `notElem` bs
  where parts = splitOn "," c
        p     = head (drop 5 parts) -- ahh, that magic number 5 again :)
