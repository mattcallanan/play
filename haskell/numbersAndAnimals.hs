--http://www.fsharp.it/

-- The file input.txt contains lists of words, one per line, in two categories, 
-- NUMBERS and ANIMALS. A line containing just a category name indicates that the words on 
-- the following lines, until the next category name, belong to that category. Read this file 
-- as input (on stdin) and print out a) a sorted list of the unique animal names encountered, 
-- and b) a list of the number words encountered, along with the count of each. Feel free to 
-- chose your output format. 

-- NUMBERS
-- one
-- three
-- two
-- one
-- three
-- ANIMALS
-- sheep
-- horse
-- cow
-- horse
-- NUMBERS
-- seven
-- ANIMALS
-- NUMBERS
-- six
-- six
-- ANIMALS
-- moose

import Data.List

process :: ([String],[String]) -> [String] -> ([String],[String])
process (ns,as) [] = (ns,as)
process (ns,as) (x:xs)
 | x == "NUMBERS" = process (ns ++ processNumbers xs, as) xs
 | x == "ANIMALS" = process (ns, as ++ processAnimals xs) xs
 | otherwise = process (ns, as) xs


processNumbers :: [String] -> [String]
processNumbers [] = []
processNumbers (x:xs) 
 | x == "NUMBERS" = processNumbers xs
 | x == "ANIMALS" = []
 | otherwise = x : processNumbers xs
 
processAnimals :: [String] -> [String]
processAnimals [] = []
processAnimals (x:xs) 
 | x == "NUMBERS" = []
 | x == "ANIMALS" = processAnimals xs
 | otherwise = x : processAnimals xs
 
input = ["NUMBERS", "one", "three", "two", "one", "three", "ANIMALS", "sheep", "horse", "cow", "horse", "NUMBERS", "seven", "ANIMALS", "NUMBERS", "six", "six", "ANIMALS", "moose"]
animalsOrNumbers = process ([],[]) input

filterThem (ns, as) = (sort $ nub as, ns)

main = let (as, ns) = filterThem animalsOrNumbers in
    do 
        putStrLn $ "Animals: " ++ show as
        putStrLn $ "Numbers: " ++ show ns

main2 = do 
    putStrLn $ "Animals: " ++ show as
    putStrLn $ "Numbers: " ++ show ns
    where  (as, ns) = filterThem animalsOrNumbers

