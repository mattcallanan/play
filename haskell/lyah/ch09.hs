import Data.Char
import Control.Monad

{-
1) Write a program which asks the user for the base and height of a right angled triangle,
calculates its area and prints it to the screen. The interaction should look something like:

The base?
3.3
The height?
5.4
The area of that triangle is 8.91

Hint: you can use the function read to convert user strings like "3.3" into numbers like 3.3
and function show to convert a number into string.
-}


main = do
    putStr "The base?"
    base <- getLine
    putStrLn "The height?"
    height <- getLine
    putStrLn ("Area: " ++ show ((read base :: Float) * (read height :: Float) / 2))


{-
2) Write a program that asks the user for his or her name.
If the name is one of Simon, John or Phil, tell the user that you think Haskell is a great programming language.
If the name is Koen, tell them that you think debugging Haskell is fun.
Otherwise, tell the user that you don't know who he or she is.

Write two different versions of this program, one using if statements, the other using a case statement.
-}

main2If = do
    putStrLn "Name?"
    name <- getLine
    if name `elem` ["Simon", "John", "Phil"] 
        then putStrLn "Haskell is great"
    else 
        if name == "Koen" 
            then putStrLn "Debugging Haskell is fun"
        else 
            putStrLn "You are insignificant."

main2Case = do
    putStrLn "Name?"
    name <- getLine
    putStrLn (case name of 
                "Simon" -> "Haskell is great"
                "John" -> "Haskell is great"
                "Phil" -> "Haskell is great"
                "Koen" -> "Debugging"
                _ -> "Whatever")
 
main2When = do
    putStrLn "Name?"
    name <- getLine
    when (name `elem` ["Simon", "John", "Phil"]) $ putStrLn "Haskel is great"
    when (name == "Koen") $ putStrLn "Debugging"


{-
3) Consider two versions of the same program:

a)  do name <- getLine
       let loudName = makeLoud name
       putStrLn ("Hello " ++ loudName ++ "!")
       putStrLn ("Oh boy! Am I excited to meet you, " ++ loudName)
       
b)  do name <- getLine
       let loudName = makeLoud name
       in  do putStrLn ("Hello " ++ loudName ++ "!")
           putStrLn ("Oh boy! Am I excited to meet you, " ++ loudName)
           
Why does version b of the let binding require an extra do keyword?
Do you always need the extra do?
-}
makeLoud = map toUpper

main3 = do 
    name <- getLine
    let loudName = makeLoud name
    putStrLn ("Hello " ++ loudName ++ "!")
    putStrLn ("Oh boy! Am I excited to meet you, " ++ loudName)
  

main3b = do 
    name <- getLine
    let loudName = makeLoud name
    --in
    do 
        putStrLn ("Hello " ++ loudName ++ "!")
        putStrLn ("Oh boy! Am I excited to meet you, " ++ loudName)


main3Ed = do 
    name <- getLine
    let loudName = makeLoud name in do
        putStrLn ("Hello " ++ loudName ++ "!")
        putStrLn ("Oh boy! Am I excited to meet you, " ++ loudName)

        