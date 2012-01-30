import Data.Monoid

{-
1. Explain the difference between type constructors and value constructors.
-}
-- Type constructor creates a type (e.g. (Maybe a) is a type constructor (Maybe String) is a type)
-- Value constructor creates a value (e.g. Just "abc" creates a value of Maybe String type)


{-
2. Create a Haskell data type to represent currencies. Use record syntax. Include fields for the currency values and names, plus any other fields you like. Make sure you have at least two value constructors (eg. Aussie dollars and GBPs or notes and coins). Derive any relevant type classes (eg. Ord, Eq). Try to include an intermediate data type.
-}
class Current a where
    value :: a -> Int

data Currency = Aud {denomination :: Int} | Gbp {denomination :: Int} deriving (Eq, Ord)
instance Current Currency where
    value a = denomination a
instance Show Currency where
    show (Aud d) = "AUD$" ++ show d
    show (Gbp p) = "GBP" ++ show p

{-
3. Make use of type parameters to create a new data type to represent a currency supply. 
The currency supply type should take your currency type as a parameter. 
The type should be able to hold units of multiple currency values (although only one currency type). 
Make the currency supply type an instance of least two type classes by hand. 
Add type synonyms to one or both of your data types where appropriate to improve readability.
-}

{-
3. Create a new data type to represent a currency supply (a collection of currencies and the number of units of each). 
Include a type parameter in your constructor representing the key that will be used to look up currencies in the supply (or some other type parameter if you prefer).
The type should be able to hold units of multiple currency values (although only one currency type). 
Make the currency supply type an instance of least two type classes by hand. Add type synonyms to one or both of your data types where appropriate to improve readability.
-}

{-
data CurrencySupply k = Empty | Supply (Map.Map k Int) deriving (Read, Ord)
instance (Eq k) => Eq (CurrencySupply k) where
    Empty == Empty = True
    Supply x == Supply y = x == y
    _ == _ = False
    
instance (Show k) => Show (CurrencySupply k) where
    show Empty = "Empty "
    show (Supply x) = show x

currencySupplyFromList :: Ord k => [(k, Int)] -> CurrencySupply k
getUnits :: Ord k => CurrencySupply k -> k -> Maybe Int
-}

data CurrencySupply = CurrencySupply {currency :: Currency, numberOfNotes :: Int} deriving (Show, Eq)

testCurrencySupply = CurrencySupply (Aud 50) 15
-- how to make CurrencySupply only take homogenous Currencies?
--  data (Currency c) => CurrencySupply c = CurrencySupply c deriving Show
--  `Currency' is applied to too many type arguments in the data type declaration for `CurrencySupply'
-- "never add typeclass constraints in data declarations"


{-
4. Create a cashDispenser function that takes a currency supply type and an amount to dispense, and returns a new currency supply with the amount withdrawn (optionally also return a second currency supply representing the amount withdrawn (ie: the number of units of each currency required to withdraw it); you could also return this instead of the currency supply with the amount withdrawn – choose your own adventure!). For simplicity, you can choose to only allow amounts to be withdrawn using a single currency (ie. dispenser cannot dispense $50 x 1 and $20 x 1 for $90, and $90 cannot be withdrawn in only $50 or $20, so a currency dispenser with a currency supply containing only these currency values could not dispense $90). Use the Either type to give different failure messages if the amount cannot be withdrawn.
-}
totalValue (CurrencySupply (Aud denomination) amt) = denomination * amt
totalValue (CurrencySupply (Gbp denomination) amt) = denomination * amt

cashDispenserSimple :: CurrencySupply -> Int -> CurrencySupply
cashDispenserSimple (CurrencySupply (Aud denomination) amt) toWithdraw = CurrencySupply (Aud denomination) (amt - toWithdraw)
testCashDispenserSimple = (cashDispenserSimple (CurrencySupply (Aud 50) 15) 5) == (CurrencySupply (Aud 50) 10)

--cashDispenser :: CurrencySupply -> Int -> CurrencySupply
cashDispenser :: CurrencySupply -> Int -> Either String CurrencySupply
cashDispenser (CurrencySupply curr@(Aud denomination) amt) toWithdraw = if notDivisible then notDivisibleError else if notEnoughCash then notEnoughCashError else Right $ CurrencySupply (Aud denomination) (amt - notesRequired)
    where notDivisible = ((mod toWithdraw denomination) /= 0)
          notDivisibleError = Left ("Can't dispense " ++ show toWithdraw ++ " with currency of " ++ show curr)
          notesRequired = (div toWithdraw denomination)
          notEnoughCash = notesRequired > amt
          notEnoughCashError = Left ("This ATM has recently been robbed.")
          
testCashDispenser1 = (cashDispenser (CurrencySupply (Aud 50) 15) 150) == Right (CurrencySupply (Aud 50) 12)
testCashDispenser2 = (cashDispenser (CurrencySupply (Aud 50) 15) 160) == Left "Can't dispense 160 with currency of AUD$50"
testCashDispenser3 = (cashDispenser (CurrencySupply (Aud 20) 10) 220) == Left "This ATM has recently been robbed."

{-
5. Create a currency supply that can only dispense 20 and 50 values of some currency type. Implement a binary search tree through which you can look up the currency supply combination to dispense when particular amounts are requested (ie: the tree node keys will be amounts and the values will be currency supplies). Include common amounts for up to 200 currency units in your tree (ie: 20, 50, 60, 70, 80, 90, 100, 110 ... 200). Create a new cashDispenser function that uses this tree to decide what currency supply combination to withdraw. Make sure some sort of failure still results if an amount cannot be dispensed.
-}
supplyValue :: CurrencySupply -> Int
supplyValue (CurrencySupply c amt) = value c * amt



data CurrencySupply2 = CurrencySupply2 {twenties :: Integer, fifties :: Integer} deriving (Eq)
instance Show CurrencySupply2 where
    show c = "$" ++ show (valueCS2 c) ++ "(" ++ show (twenties c) ++ "*$20," ++ show (fifties c) ++ "*$50)"
instance Ord CurrencySupply2 where
    x `compare` y = (valueCS2 x) `compare` (valueCS2 y)

valueCS2 :: CurrencySupply2 -> Integer
valueCS2 c = (twenties c * 20) + (fifties c * 50)

maybeSupplies = foldr currSupps [] [20,30..1000]
    where currSupps x supps = currSupp x : supps
          currSupp 30 = Nothing
          currSupp x = if x `elem` fifties then Just (CurrencySupply2 0 (x `div` 50)) else Just (f x)
                       where fifties = filter ((==) 0 . flip mod 50) [20,30..1000]
                             f x = if x `mod` 50 `mod` 20 == 0 
                                   then (CurrencySupply2 (x `mod` 50 `div` 20) (x `div` 50))
                                   else (CurrencySupply2 ((x - ((g x) * 50)) `div` 20) (g x))
                             g x = (x `div` 50) - 1

definiteSupplies = [x | (Just x) <- maybeSupplies]

data CurrencySupplyTree a = EmptyTree | Node (CurrencySupplyTree a) a (CurrencySupplyTree a) deriving Show

treeInsert :: (Eq a, Ord a) => CurrencySupplyTree a -> a -> CurrencySupplyTree a
treeInsert EmptyTree x = Node EmptyTree x EmptyTree
treeInsert n@(Node left a right) x
    | x == a = Node left a right
    | x < a  = Node (treeInsert left x) a right
    | x > a  = Node left a (treeInsert right x)

buildTree = foldr (flip treeInsert) EmptyTree definiteSupplies

--testCSTree = treeInsert Node (CurrencySupply2 0 1)  (CurrencySupply2 1 1) 

--foldr [(CurrencySupply2 0 1),(CurrencySupply2 1 0),(CurrencySupply2 2 0),(CurrencySupply2 1 1),(CurrencySupply2 2 1),(CurrencySupply2 3 0),(CurrencySupply2 0 2),CurrencySupply2 2 1)]


{-
6. Using YesNo for inspiration, write a type class called Valuable that defines one function that returns an Int representing how valuable something is (on some arbitrary scale). Make your currency and currency supply types plus at least one standard Haskell data type instances of this type class. Use :k to check its kind.
-}
class Valuable a where
    valuable :: a -> Bool
    notValuable :: a -> Bool
    valuable x = not (notValuable x)
    notValuable x = not (valuable x)

instance Valuable CurrencySupply2 where
    valuable cs = valueCS2 cs > 500

instance Valuable Bool where
    valuable x = x == True

newtype StringWrapper = StringWrapper String
instance Valuable StringWrapper where
    valuable (StringWrapper "Gold") = True
    valuable (StringWrapper "Silver") = True
    valuable (StringWrapper "Ruby") = True
    valuable (StringWrapper "Haskell") = True
    valuable _ = False
    
{-
7. Make one of your data types an instance of Functor, or explain why you cannot do so.
-}

instance Functor CurrencySupplyTree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node left cs2 right) = Node (fmap f left) (f cs2) (fmap f right)



instance Monoid CurrencySupply2 where
    mempty = CurrencySupply2 0 0
    (CurrencySupply2 t1 f1) `mappend` (CurrencySupply2 t2 f2) = (CurrencySupply2 (t1 + t2) (f1 + f2))

