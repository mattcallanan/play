-- From: http://learnyouahaskell.com/making-our-own-types-and-typeclasses
module Shapes (Point(..), Shape(..), surface, nudge, baseCircle, baseRect) where
data Point = Point Float Float deriving (Show)  
data Shape = Circle Point Float | Rectangle Point Point deriving (Show)

surface :: Shape -> Float  
surface (Circle _ r) = pi * r ^ 2  
surface (Rectangle (Point x1 y1) (Point x2 y2)) = (abs $ x2 - x1) * (abs $ y2 - y1)

nudge :: Shape -> Float -> Float -> Shape  
nudge (Circle (Point x y) r) a b = Circle (Point (x+a) (y+b)) r  
nudge (Rectangle (Point x1 y1) (Point x2 y2)) a b = Rectangle (Point (x1+a) (y1+b)) (Point (x2+a) (y2+b))

baseCircle :: Float -> Shape  
baseCircle r = Circle (Point 0 0) r  

baseRect :: Float -> Float -> Shape  
baseRect width height = Rectangle (Point 0 0) (Point width height) 

-- map (Circle 10 20) [4,5,6,6]
-- surface $ Circle 10 20 10  
-- surface $ Rectangle 0 0 100 100  
-- surface (Rectangle (Point 0 0) (Point 100 100))  
-- surface (Circle (Point 0 0) 24)
