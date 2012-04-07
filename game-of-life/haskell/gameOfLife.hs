run world = mainR world 1

mainR world count = printWorld world count >> mainR (progress world) (count+1)

progress world = [(x,y) | x <- [minX world..maxX world], y <- [minY world..maxY world], willLive (x,y) world]

minX world = (minimum $ fst $ unzip world) - 1
maxX world = (maximum $ fst $ unzip world) + 1
minY world = (minimum $ snd $ unzip world) - 1
maxY world = (maximum $ snd $ unzip world) + 1

willLive (x,y) world 
    | (x,y) `elem` world = n `elem` [2,3]
    | otherwise = n == 3
    where n = (liveNeighbours (x,y) world)

liveNeighbours (x,y) world = length [(x,y) | oX <- [-1..1], oY <- [-1..1], not (oX == 0 && oY == 0), elem (x+oX, y+oY) world]

printWorld world count = putStrLn $ toString world count
--display zs = sequence_ [putStrLn (a++" = "++b) | (a,b) <- zs]

toString world count = concat [(cellString (x,y) world) | y <- [smly..bigy], x <- [smlx..bigx]] ++ "\n^" ++ (show count) ++ "------------------------------(" ++ (show smlx) ++ "," ++ (show smly) ++ ")-(" ++ (show bigx) ++ "," ++ (show bigy) ++ ") = " ++ (show cellCount)
    where smlx = minX world
          smly = minY world
          bigx = maxX world
          bigy = maxY world
          cellCount = (bigx - smlx) * (bigy - smly)
          
cellString (x,y) world
    | (x,y) `elem` world = br ++ "*"
    | otherwise = br ++ "."
    where br = if x == minX world then "\n" else ""

-- EXAMPLE WORLDS
glider = [(2,1),(3,2),(1,3),(2,3),(3,3)]
acorn = [(2,1),(4,2),(1,3),(2,3),(5,3),(6,3),(7,3)]
startWorld = [(1,1), (2,1), (1,2), (1,3)]
endWorld = [(0,2), (1,1), (1,2), (2,1)]





-- TESTS	
testLN1 = liveNeighbours (2,2) startWorld == 4
testLN2 = liveNeighbours (1,2) startWorld == 3
testLN3 = liveNeighbours (2,1) startWorld == 2
testLN4 = liveNeighbours (1,3) startWorld == 1
testLN5 = liveNeighbours (3,3) startWorld == 0

testAlive0 = willLive(1,1) startWorld == True
testAlive1 = willLive(2,2) startWorld == False
testAlive2 = willLive(1,3) startWorld == False
testAlive3 = willLive(0,2) startWorld == True

testProgress0 = progress startWorld == endWorld
