{-
By Andrew Newman 18-Apr-2012
This is a slightly optimised version of the countdown program I've
been talking about.  No nexus yet but still pretty fast (~3 seconds on
my old clunker).

display (countdown 831 [1,3,7,10,25,50]) - (the answer is the second
tuple - snd $ countdown 831 [1,3,7,10,25,50]).
-}
import Data.Time

countdown :: Int -> [Int] -> (Expr, Value)
countdown n = nearest n . concatMap mkExprs . subseqs

display f = do
	start <- getCurrentTime
	result <- print $ f
	stop <- getCurrentTime
	print $ diffUTCTime stop start
	return result

subseqs [x] = [[x]]
subseqs (x:xs) = xss ++ [x] : map (x:) xss
	where xss = subseqs xs

data Op = Add | Sub | Mul | Div deriving (Show)
data Expr = Num Int | App Op Expr Expr deriving (Show)
type Value = Int

value :: Expr -> Value
value (Num x) = x
value (App op e1 e2) = apply op (value e1) (value e2)

apply :: Op -> Value -> Value -> Value
apply Add = (+)
apply Sub = (-)
apply Mul = (*)
apply Div = (div)

legal :: Op -> Value -> Value -> Bool
legal Add v1 v2 = (v1 <= v2)
legal Sub v1 v2 = (v2 < v1)
legal Mul v1 v2 = (1 < v1) && (v1 <= v2)
legal Div v1 v2 = (1 < v2) && (v1 `mod` v2 == 0)

mkExprs :: [Int] -> [(Expr, Value)]
mkExprs [x] = [(Num x, x)]
mkExprs xs = [ev | (ys, zs) <- unmerges xs,
		ev1 <- mkExprs ys,
		ev2 <- mkExprs zs,
		ev <- combine ev1 ev2]
		
unmerges :: [a] -> [([a], [a])]
unmerges [x, y] = [([x], [y])]
unmerges (x:xs) = [([x], xs)] ++
	concatMap (add x) (unmerges xs)
	where add x (ys, zs) = [(x : ys, zs), (ys, x : zs)]
	
combine :: (Expr, Value) -> (Expr, Value) -> [(Expr, Value)]
combine (e1, v1) (e2, v2) = [(App op e1 e2, apply op v1 v2) | op <- ops, legal op v1 v2] ++
	[(App op e2 e1, apply op v2 v1) | op <- ops, legal op v2 v1]
ops = [Add, Sub, Mul, Div]

nearest n ((e,v) : evs) = if d == 0 then (e,v)
	else search n d (e, v) evs
	where d = abs (n - v)
	
search n d ev [] = ev
search n d ev ((e, v) : evs)
	| d' == 0 = (e,v)
	| d' < d = search n d' (e,v) evs
	| d' >= d = search n d ev evs
		where d' = abs (n - v)
		
