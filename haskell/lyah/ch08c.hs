
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


data CurrencySupplyTree a = Empty | Node (CurrencySupplyTree a) a (CurrencySupplyTree a)

treeInsert :: CurrencySupplyTree a -> Currency -> CurrencySupplyTree a
treeInsert Empty curr = Node Empty curr Empty
treeInsert (Node left val right) curr
    | (supplyValue left == supplyValue curr) = Node left val right
    | (supplyValue left  < supplyValue curr) = Node (treeInsert left curr) right
    | (supplyValue left  > supplyValue curr) = Node left (treeInsert right curr)

fromList :: [Currency] -> CurrencySupplyTree a
fromList [] = Empty
fromList xs = foldl (flip . treeInsert) Empty xs


{-
6. Using YesNo for inspiration, write a type class called Valuable that defines one function that returns an Int representing how valuable something is (on some arbitrary scale). Make your currency and currency supply types plus at least one standard Haskell data type instances of this type class. Use :k to check its kind.
-}

{-
7. Make one of your data types an instance of Functor, or explain why you cannot do so.
-}

