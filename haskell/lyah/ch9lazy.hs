import System.IO  
import System.IO.Error
import System.Environment
import System.Random
import System.Exit

main = do  
    handle <- openFile "abc.txt" ReadMode  
    hSetBuffering handle LineBuffering
    contents <- hGetContents handle  
    putStr $ reverse contents  
    hClose handle
