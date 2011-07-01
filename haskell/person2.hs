-- From: http://learnyouahaskell.com/making-our-own-types-and-typeclasses
module Person (Person(..)) where
data Person = Person { firstName :: String  
                     , lastName :: String  
                     , age :: Int  
                     , height :: Float  
                     , phoneNumber :: String  
                     , flavor :: String  
                     } deriving (Show, Eq, Read)


-- let guy = Person "Buddy" "Finklestein" 43 184.2 "526-2928" "Chocolate"
-- firstName guy

-- let guy = Person {firstName="Buddy", lastName="Finklestein", height=43, age=184, phoneNumber="526-2928", flavor="Chocolate"}