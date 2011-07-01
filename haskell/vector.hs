-- From: http://learnyouahaskell.com/making-our-own-types-and-typeclasses
-- data <Type constructor> = <Value constructor(s)>
-- "a" is a "type variable" - allows polymorphism
data Vector a = Vector a a a deriving (Show)  

-- Vector type constructor (Vector a) goes in function's type declaration...
-- Everything before the => symbol is called a "class constraint"
vplus :: (Num t) => Vector t -> Vector t -> Vector t  
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)  
  
vectMult :: (Num t) => Vector t -> t -> Vector t  
(Vector i j k) `vectMult` m = Vector (i*m) (j*m) (k*m)  
  
scalarMult :: (Num t) => Vector t -> Vector t -> t  
(Vector i j k) `scalarMult` (Vector l m n) = i*l + j*m + k*n  

--Vector 3 5 8 `vplus` Vector 9 2 8  
--Vector 3 5 8 `vplus` Vector 9 2 8 `vplus` Vector 0 2 3  
--Vector 3 9 7 `vectMult` 10  
--Vector 4 9 5 `scalarMult` Vector 9.0 2.0 4.0  
--Vector 2 9 3 `vectMult` (Vector 4 9 5 `scalarMult` Vector 9 2 4)
