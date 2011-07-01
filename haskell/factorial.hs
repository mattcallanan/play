module Main where
 
factorial 0 = 1
factorial n = n * factorial (n - 1)
 
main = do putStrLn "What is 5! ?"
          x <- readLn
          if x == factorial 5
              then putStrLn "You're right!"
              else putStr "You're wrong! answer is " ; print (factorial 5)