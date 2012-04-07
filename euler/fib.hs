fib 1 = 1
fib 2 = 2
fib n = (fib (n-1)) + (fib (n-2))

prob02 = sum . takeWhile (<=400) . filter even $ (map fib [1..])
