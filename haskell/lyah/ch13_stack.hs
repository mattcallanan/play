import Control.Monad.State
import Control.Monad.Identity

type Stack = [Int]

pop :: Stack -> (Int,Stack)  
pop (x:xs) = (x,xs)  

push :: Int -> Stack -> ((),Stack)  
push a xs = ((),a:xs)  

stackManip :: Stack -> (Int, Stack)
stackManip stack = let
    ((),newStack1) = push 3 stack
    (_ ,newStack2) = pop newStack1
    in pop newStack2



--newtype State s a = State { runState :: s -> (a,s) }
--
--instance Monad (State s) where
--    return x = State $ \s -> (x,s)
--    (State h) >>= f = State $ \s -> let (a, newState) = h s
--                                        (State g) = f a
--                                    in  g newState


--pop' :: State Stack Int
pop' = state $ \(x:xs) -> (x, xs)
--pop' = StateT $ \(x:xs) -> Identity (x,xs)

--push :: Int -> State Stack ()
push' a = state $ \xs -> ((),a:xs)


--stackManip' :: State Stack Int
-- runState stackManip' [1..10]
stackManip' = do
    push' 3
    a <- pop'
    pop'

--stackManip'' = push' 3 -- >> pop >> pop