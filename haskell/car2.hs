-- From: http://learnyouahaskell.com/making-our-own-types-and-typeclasses
data Car a b c = Car { company :: a  
, model :: b  
, year :: c   
} deriving (Show)  

tellCar :: (Show a) => Car String String a -> String  
tellCar (Car {company = c, model = m, year = y}) = "This " ++ c ++ " " ++ m ++ " was made in " ++ show y

tellCar2 :: (Show a, Show b, Show c) => Car a b c -> String  
tellCar2 (Car {company = c, model = m, year = y}) = "This " ++ show c ++ " " ++ show m ++ " was made in " ++ show y


{-
tellCar (Car "Ford" "Mustang" 1967)  
tellCar (Car "Ford" "Mustang" "nineteen sixty seven")  
:t Car "Ford" "Mustang" 1967  
:t Car "Ford" "Mustang" "nineteen sixty seven"  
-}
