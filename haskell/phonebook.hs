import Data.Map

-- From: http://learnyouahaskell.com/making-our-own-types-and-typeclasses
-- Type Synonyms
type PhoneNumber = String  
type Name = String  
type PhoneBook = [(Name,PhoneNumber)] 

inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool  
inPhoneBook name pnumber pbook = (name,pnumber) `elem` pbook 

--a type constructor that takes two types and produces a concrete type, like AssocList Int String, for instance.
type AssocList k v = [(k,v)]  
-- let x = [("123",4)] :: AssocList String Int


type IntMap v = Map Int v
type IntMap2 = Map Int  
