qs [] = []
qs (x:xs) = qs [n | n <- xs, n <= x] ++ [x] ++ qs [n | n <- xs, n > x]

qs' [] = []
qs' (x:xs) = qs (filter (<= x) xs) ++ [x] ++ qs (filter (> x) xs)

qs'' [] = []
-- qs'' (x:xs) = qs (filt (<=)) ++ [x] ++ qs (filt (>))
--    where filt f = filter (f x) xs
qs'' (x:xs) = qs (filt (<= x)) ++ [x] ++ qs (filt (> x))
    where filt f = filter (f) xs
