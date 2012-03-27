import System.IO  
import System.Environment
import System.Random
import qualified Data.ByteString.Lazy as B  
import qualified Data.ByteString as S  
import qualified Data.ByteString.Char8 as C

{-
Week 10 Ch9b More Input and Output
1)  Write "mirror.hs", an application that takes two command-line args like so:
        mirror <inputfile> <outputfile>
    Using streams and bytestrings, it reads a line from the inputfile, reverses it, and writes the reversed line to the outputfile.
    If an incorrect number of arguments has been supplied, print the following message and exit.
	    "Usage: mirror <inputfile> <outputfile>"
    Write an error handler that catches the following exceptions and displays an error message:
        - isDoesNotExistError:  "Input file [filename] does not exist"
        - isAlreadyExistsError: "Output file [filename] already exists"
    Make sure any open file handles are closed.
    
    Tip: Exceptions are covered only in the online book: http://learnyouahaskell.com/input-and-output#exceptions
-}

main = do
--    (source:dest:_) <- getArgs
    args <- getArgs
    let (source:dest:_) = args
    putStrLn (source ++ " -> " ++ dest)
    h <- openFile source ReadMode
    w <- openFile dest   WriteMode
    contents <- C.hGetContents h
    let x = map (reverse . C.unpack) (C.lines contents)
    mapM (hPutStr w) x
    hClose h
    hClose w


main1 = do  
    handle <- openFile "abc.txt" ReadMode  
    hSetBuffering handle LineBuffering
    contents <- hGetContents handle  
    putStr $ reverse contents  
    hClose handle

	
mainWithFile = do  
    withFile "abc.txt" ReadMode (\handle -> do  
    contents <- hGetContents handle     
    putStr $ reverse contents)  

    
    
lowercasePwd = newStdGen >>= \y -> return $ take 20 $ randomRs ('a','z') y    
    
    

-- >> h <- openFile "abc.txt" ReadMode
-- >> hGetBuffering h
-- BlockBuffering Nothing
