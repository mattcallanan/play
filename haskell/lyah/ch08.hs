--data TrafficLight = Red | Yellow | Green deriving (Eq, Show)
data TrafficLight = Red | Yellow | Green deriving (Eq, Ord)

{-
instance Eq TrafficLight where  
    Red == Red = True  
    Green == Green = True  
    Yellow == Yellow = True  
    _ == _ = False  
-}

instance Show TrafficLight where
    show Red = "Stop"
    show Yellow = "Wait"
    show Green = "Go"
