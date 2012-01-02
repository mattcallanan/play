    import Debug.Trace

    hanoi' disk towers
        | trace (show towers) False = undefined
        | disk == 0 = moveTopDisk disk towers
        | otherwise = step3 disk (step2 disk (step1 disk towers))
            where step1 disk (a:b:[c]) = let (a':c':[b']) = hanoi' (disk-1) [a,c,b] in [a', b', c']
                  step2 disk towers = moveTopDisk disk towers
                  step3 disk (a:b:[c]) = let (b':a':[c']) = hanoi' (disk-1) [b,a,c] in [a', b', c']
                  moveTopDisk disk (a:b:[c]) = [tail a,b,head a:c]
