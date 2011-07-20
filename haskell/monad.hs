main = putStrLn "Enter a line of text:" 
    >> getLine >>= \x -> putStrLn (reverse x)
    
mainBind = putStrLn "Enter a line of text:" 
    >>= \_ -> getLine >>= \x -> putStrLn (reverse x)
    
mainDo = do putStrLn "Enter a line of text:" 
            x <-  getLine
            putStrLn (reverse x)