module Main where
 
import qualified Data.Map as M
 
errorsPerLine = M.fromList
    [ ("Chris", 472), ("Don", 100), ("Simon", -5) ]

main = do {
          putStrLn "Who are you?";
          name <- getLine;
          myLookup name
       }

myLookup name = case M.lookup name errorsPerLine of {
              Nothing -> putStrLn "I don't know you";
              Just n  -> printErrors n
          }
 
printErrors n = do {
                    putStr "Errors per line: ";
                    print n;
                }
