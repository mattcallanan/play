
data Tree = Empty
          | Leaf Int
          | Node Tree Tree
          deriving (Show)
          
count :: Tree -> Int
count Empty = 0
count (Leaf v) = 1
count (Node l r) = count l + count r
