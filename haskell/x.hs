processNumbers (x:xs) 
    | x == "NUMBERS" = processNumbers xs
    | x == "ANIMALS" = []
    | otherwise = x : processNumbers xs
    
processAnimals (x:xs) 
    | x == "NUMBERS" = []
    | x == "ANIMALS" = processAnimals xs
    | otherwise = x : processAnimals xs
