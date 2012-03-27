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
    return ()
