-- session2.hs

-- e.g. class List<A>
data List a = Nil | Cons a (List a)
  deriving (Show, Eq, Ord)

-- Cons 1 (Cons 5 Nil)

single :: a -> List a
single x = Cons x Nil

rep :: a -> List a
rep a = Cons a (rep a)

takee :: Int -> List a -> List a
takee n _ | n <= 0 = Nil
takee _ Nil = Nil
takee n (Cons h t) = Cons h (takee (n-1) t)

mapp :: List a -> (a -> b) -> List b
mapp Nil _ = Nil
mapp (Cons h t) f = Cons (f h) (mapp(t) f)

mapp2 :: (a -> b) -> List a -> List b
mapp2 _ Nil = Nil
mapp2 f (Cons h t) = Cons (f h) (mapp2 f t)


instance Functor List where
--  fmap :: Functor f => (a -> b) -> f a -> f b
  fmap = mapp2

-- fmap (+1) (Cons 9 Nil)

append :: List a -> List a -> List a
append Nil x = x
append (Cons h t) x = Cons h (append t x)

flatten :: List (List a) -> List a
flatten Nil = Nil
flatten (Cons h t) = append h (flatten t)


bind :: (a -> List b) -> List a -> List b
bind f x = flatten (mapp2 f x)

bind2 :: (a -> List b) -> List a -> List b
bind2 f = flatten . mapp2 f

(...) = flip (.)

bind3 :: (a -> List b) -> List a -> List b
bind3 f = mapp2 f ... flatten

bindd :: List a -> (a -> List b) -> List b
bindd = flip bind

-- (>>=) :: Monad m => m a -> (a -> m b) -> m b

{-
*Main> :t (>>=) (Cons 8 Nil) single

<interactive>:1:1:
    No instance for (Monad List)
      arising from a use of `>>='
    Possible fix: add an instance declaration for (Monad List)
    In the expression: (>>=) (Cons 8 Nil) single
-}    
    
instance Monad List where
  (>>=) = bindd
  return = single

-- (>>) anonymous bind - calls bind implicitly
  
{-
*Main> :t sequence
sequence :: Monad m => [m a] -> m [a]
-}

-- sequence [Cons 7 (Cons 8 (Cons 9 Nil)), Cons 1 (Cons 2 Nil)]

{-
*Main> :t print
print :: Show a => a -> IO ()

*Main> :t sequence [print "hi"]
sequence [print "hi"] :: IO [()]
-}

-- sequence_ [print "hi", print "bye"]

-- :m + Control.Monad
-- :m + Control.Monad.Instances

{-
Prelude Control.Monad> :t replicateM
replicateM :: Monad m => Int -> m a -> m [a]
-}

-- replicateM 4 (print "hi")
-- replicateM 4 [1,2,3]
-- replicateM 4(Cons 1 (Cons 2 Nil))

{-
Reader Monad
[v -> a] -> (v -> [a])
[v -> a] -> v -> [a]
-}

