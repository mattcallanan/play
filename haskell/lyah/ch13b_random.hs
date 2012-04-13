import Control.Monad.State

{--
Exercise 1
Given the WriterMonad and the StateMonad can both store some kind of state,
compare and contrast the two monads and explain where you would use one over the other.
--}

{-- Exercise 2 --}
data Queue a = EmptyQ | Q[a] deriving (Show, Eq)

colours = ["red", "green", "blue", "yellow", "magenta", "teal", "burgundy", "gray"]
numbers = [1..100]

testColours = (((runState stateColours) $ Q(colours)) == ((), Q["red", "green", "magenta"]))    
testNumbers = (((runState stateNumbers) $ Q(numbers)) == ((), Q[404]))

stateColours :: State (Queue String) ()
stateColours = do
  enqueue "maroon"
  enqueue "scarlet"
  filterQ ('l' `notElem`)
  dequeue
  filterQ('e' `elem`)

stateNumbers :: State (Queue Int) ()
stateNumbers  = do
  dequeue
  dequeue
  filterQ (\x -> x >= 40 && x <= 50)
  enqueue 101
  filterQ (\x -> x `mod` 2 == 0)
  dequeue
  dequeue
  filterQ (\x -> x `mod` 2 /= 0)
  enqueue 404

--write implementations for the following:

enqueue :: a -> State (Queue a) ()  --adds an element to the end of the Queue
enqueue x = state $ \(Q xs) -> ((), (Q (x:xs)))

dequeue :: State (Queue a) ()  --removes the last element
dequeue = state $ \(Q (_:xs)) -> ((), Q(xs))

filterQ ::(Eq a) => (a -> Bool) -> State (Queue a) () --returns elements of the Queue that satisfy the predicate
filterQ p =  state $ \(Q xs) -> ((), Q(filter p xs))

x = do
      enqueue "maroon"
      enqueue "scarlet"

{-
Exercise 3
What would we gain/lose if we implemented the above exercise without the State Monad?

Gain: clarity
Lose: ability to use 'do' notation
-}