-- The following function calculates the radius of a circle and takes a Floating and returns a Floating:
--    let radius r = 2 * pi * r
-- Write it with a type definition where it only accepts Integers, and returns a Double:
radius :: Integer -> Double
radius r = 2.0 * pi * fromInteger(r)

-- Write a function called push that takes any Num, and a list of Num, and returns a new list with the item we're adding at the head of the list. Eg:
--    push 1 [2, 3] == [1, 2, 3]
-- The function should not compile when either the list, or the item we're pushing, is not a Num.

{-ch03.hs:10:9:
    Class `Num' used as a type
    In the type signature for `push': push :: Num -> [Num]-}
push :: Num a => a -> [a] -> [a]
push = (:)

-- Write an infix version of push. You could reuse your answer from #2 to help. Eg:
--    1 >> [2, 3] == [1, 2, 3]
{-    Ambiguous occurrence `>>'
    It could refer to either `Main.>>', defined at ch03.hs:19:1
                          or `Control.Monad.Instances.>>',
                             imported from Control.Monad.Instances -}
--(>>>) :: Num a => a -> [a] -> [a]
(>>>) = push
