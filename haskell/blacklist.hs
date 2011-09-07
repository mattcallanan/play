main =
    do p <- readFile "customers.csv"
       g <- readFile "blacklist.csv"
       return (p ++ g)
