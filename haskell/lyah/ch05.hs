import Debug.Trace


dubFac 0 = 0
dubFac 1 = 1
dubFac 2 = 2
dubFac n 
    | n < 0 = error "invalid"
	|otherwise = n * dubFac (n-2)




dubFac' x = dubFacTail x 1
    where dubFacTail n a
              | n < 2 = a
              | otherwise = dubFacTail (n-2) (n*a)

doubleF n = doubleF' n 1
doubleF' 0 a = a
doubleF' 1 a = a
doubleF' n a = doubleF' (n-2) (n*a)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

log2 n 
    | n < 2 = 0
    | otherwise = 1 + log2 (n/2)

--log2' n = log2T n 
--log2T 1 a = a
--log2T n a = log2T (n/2) (a+1)
    
    
log2' = truncate . sqrt







--hanoiA n x y z | trace ("n:" ++ show n ++ ", x:" ++ show x ++ ", y:" ++ show y ++ ", z:" ++ show z) False = undefined
hanoiA 0 _ _ _ = []
--hanoiA n x y z = hanoiA (n-1) x z y ++ [(x,y)] ++ hanoiA (n-1) z y x
hanoiA n x y z = hanoiA (n-1) x z y ++ [(x,z)] ++ hanoiA (n-1) y x z

applyMoves ((from,to):nextMoves) pegs | trace ("(from:" ++ show from ++ ", to:" ++ show to ++ ") pegs:" ++ show pegs) False = undefined
applyMoves [] pegs = pegs
applyMoves ((1,2):nextMoves) pegs = applyMoves nextMoves [tail (pegs!!0),         head (pegs!!0):pegs!!1, pegs!!2]
applyMoves ((1,3):nextMoves) pegs = applyMoves nextMoves [tail (pegs!!0),         pegs!!1,                head (pegs!!0):pegs!!2]
applyMoves ((2,1):nextMoves) pegs = applyMoves nextMoves [head (pegs!!1):pegs!!0, tail (pegs!!1),         pegs!!2]
applyMoves ((2,3):nextMoves) pegs = applyMoves nextMoves [pegs!!0,                tail (pegs!!1),         head (pegs!!1):pegs!!2]
applyMoves ((3,1):nextMoves) pegs = applyMoves nextMoves [head (pegs!!2):pegs!!0, pegs!!1,                tail (pegs!!2)]
applyMoves ((3,2):nextMoves) pegs = applyMoves nextMoves [pegs!!0,                head (pegs!!2):pegs!!1, tail (pegs!!2)]
applyMoves (dodgyMove:nextMoves) pegs = error "Invalid moves: "


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

