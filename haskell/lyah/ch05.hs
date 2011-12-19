import Debug.Trace


dubFac 0 = 0
dubFac 1 = 1
dubFac 2 = 2
dubFac n 
    | n < 0 = error "invalid"
	|otherwise = n * dubFac (n-2)



--log2 n = 


--hanoi :: Num a => a -> [[a]] -> [[a]]

hanoi a (source:spare:[dest]) | trace ((replicate a ' ') ++ "hanoi " ++ show a ++ " source:" ++ show source ++ ", spare:" ++ show spare ++ ", dest:" ++ show dest) False = undefined
hanoi disk towers@(source:spare:[dest])
    | disk == 0 = moveTopDisk disk towers
    | otherwise = step3 disk (step2 disk (step1 disk towers))

step1 a (source:spare:[dest]) | trace ((replicate a ' ') ++ "step1 " ++ show a ++ " source:" ++ show source ++ ", spare:" ++ show spare ++ ", dest:" ++ show dest) False = undefined
step1 disk (source:spare:[dest]) = [source', spare', dest']
    where (source':dest':[spare']) = hanoi (disk-1) [source,dest,spare]

step2 a (source:spare:[dest]) | trace ((replicate a ' ') ++ "step2 " ++ show a ++ " source:" ++ show source ++ ", spare:" ++ show spare ++ ", dest:" ++ show dest) False = undefined
step2 disk towers = moveTopDisk disk towers

step3 a (source:spare:[dest]) | trace ((replicate a ' ') ++ "step3 " ++ show a ++ " source:" ++ show source ++ ", spare:" ++ show spare ++ ", dest:" ++ show dest) False = undefined
step3 disk (source:spare:[dest]) = [source', spare', dest']
    where (spare':source':[dest']) = hanoi (disk-1) [spare,source,dest]

moveTopDisk a (source:spare:[dest]) | trace ((replicate a ' ') ++ "moveT " ++ show a ++ " source:" ++ show source ++ ", spare:" ++ show spare ++ ", dest:" ++ show dest) False = undefined
moveTopDisk disk (source:spare:[dest]) = [tail source,spare,head source:dest]

              
--testHanoi = (hanoi [[1..4],[],[]]) `assertEquals` [[],[],[1..4]] 

assertEquals actual expected 
    | actual == expected = putStrLn "Passed"
    | otherwise = error ("Failed: expected " ++ show expected ++ " but was: " ++ show actual)

