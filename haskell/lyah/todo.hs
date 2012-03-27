import System.IO     
    
main = do     
    todoItem <- getLine  
    appendFile "todo.txt" (todoItem ++ "\n")  

mainDemo = do   
    withFile "something.txt" ReadMode (\handle -> do  
        contents <- hGetContents handle  
        putStr contents)  