-- ghci -XDeriveDataTypeable -XDeriveDataTypeable blacklister
import BlacklistData
import Data.List
import Data.List.Split -- for splitOn
import Control.Monad   -- for liftM
import System.CPUTime
import Text.Printf
import System.IO
import Control.Parallel.Strategies
import Control.Parallel

{-    
Storycard 1
-----------
- Using BlacklistData.hs, write "blacklister", a function that returns the customers that are blacklisted (their postcode is one of BlacklistData.blacklistedPostcodes).
- Use the Customer type exported from BlacklistData.
- Use testBlacklister below to check your results.
-}
instance Show Customer where
    show = intercalate "," . fromCustomer

ex = ["10100001","female","Alexandra","J","Kruse","29 Trelawney Street","BEN BUCKLER","NSW","2026","AU","AlexandraKruse@dodgit.com","Rae9ehee","(02) 9440 8706","Jenkins","3/11/1931","Visa","4.48589E+15","772","Oct-14","","1Z 706 396 06 2837 560 1","Microeconomist","Country Club Markets","PokerWatcher.com","A+","68.7","161"]
ex2 = toCustomer ex

toCustomer :: [String] -> Customer
toCustomer [idNumber, gender, givenName, middleInitial, surname, streetAddress, city, state, postCode, country, emailAddress, password, telephoneNumber, mothersMaiden, birthday, ccType, ccNumber, cvv2, ccExpires, nationalID, ups, occupation, company, domain, bloodType, kilograms, centimeters] = 
    Customer idNumber gender givenName middleInitial surname streetAddress city state postCode country emailAddress password telephoneNumber mothersMaiden birthday ccType ccNumber cvv2 ccExpires nationalID ups occupation company domain bloodType kilograms centimeters

--header :: Customer -> [String]
--header x = constrFields . toConstr $ x

fromCustomer :: Customer -> [String]
fromCustomer x = [idNumber x, gender x, givenName x, middleInitial x, surname x, streetAddress x, city x, state x, postCode x, country x, emailAddress x, password x, telephoneNumber x, mothersMaiden x, birthday x, ccType x, ccNumber x, cvv2 x, ccExpires x, nationalID x, ups x, occupation x, company x, domain x, bloodType x, kilograms x, centimeters x]

slurp :: [Customer]
slurp = map toCustomer customers

blacklisted :: [Customer] -> [Customer]
blacklisted = filter f where f Customer {postCode=pc} = (pc `elem` blacklistedPostcodes)

blacklister :: [String]
blacklister = map show $ blacklisted slurp
              --where f Customer {postCode=pc} = (pc `elem` blacklistedPostcodes)

testBlacklister = blacklister == expected


{-
Storycard 2
-----------
1. Add a "main" method to blacklister.hs that outputs blacklister to stdout (as lines of CSV).
2. Run "ghc blacklister"
3. Run "blacklister > blacklisted.csv"
4. Compare blacklisted.csv with expected.csv
-}

--main = mapM_ putStrLn $ blacklister
main = blacklisterPro

{-
Storycard 3
-----------
Write "blacklisterPro", an app that reads customers from "all_customers.csv" and has two forms of output:
1. Displays the IDs of all the blacklisted customers and a summary like so:
    nnnn customers blacklisted: [10100027,10100205,<etc>]
2. Writes the full records of blacklisted customers to blacklisted.csv (ordering is not important).  Use BlacklistData.columnNames for header row.
-}
-- liftM :: Monad m => (a1 -> r) -> m a1 -> m r
-- lines :: String -> [String]
-- readFile :: FilePath -> IO String
-- mapM_ :: Monad m => (a -> m b) -> [a] -> m ()

blacklisterPro :: IO b
blacklisterPro = do 
    start <- getCPUTime
    csvLines <- liftM lines (readFile "all_customers.csv")
    let allCustomers = map (toCustomer . (splitOn ",")) csvLines
    let blacklistedCustomers = blacklisted allCustomers
    let ids = map idNumber blacklistedCustomers
    putStrLn $ show (length blacklistedCustomers) ++ " customers blacklisted: " ++ (show ids)
    --mapM_ putStrLn (map show blacklistedCustomers)
    w <- openFile "blacklisted.csv" WriteMode
    hPutStrLn w (intercalate "," columnNames)
    mapM (hPutStrLn w) (map show blacklistedCustomers)
    hClose w
    end <- getCPUTime
    let diff = (fromIntegral (end - start)) / (10^12)
    printf "Computation time: %0.3f sec\n" (diff :: Double)

    {-
readCustomersText :: IO [String]
readCustomersText = do
    list <- liftM lines (readFile "all_customers.csv")
    return list

readCustomerTokens :: IO [[String]]
readCustomerTokens = (liftM (map $ splitOn ",") readCustomersText)

--readCustomers :: IO [Customer]
readCustomers = map (toCustomer) readCustomerTokens
-}
    
{-
Storycard 4
-----------
1. Write "blacklisterMapReduce", an app that retrofits "blacklisterPro" to process customers in at least 10 parallel threads/processes.
   - What difficulties are there in this approach?
   - What are the benefits of this approach?
-}
chunks :: [[Customer]]
chunks = (chunk 10000 slurp)

blacklistParallel = (parMap rseq) blacklisted chunks
