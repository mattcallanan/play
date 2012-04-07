
start_world = [(1,1), (2,1), (1,2), (1,3)]
end_world = [(0,2), (1,1), (1,2), (2,1)]

liveNeighbours (x, y) world = length [(x,y) | offsetX <- [-1..1], offsetY <- [-1..1], not (offsetX == 0 && offsetY == 0), elem (x + offsetX, y + offsetY) world]

isAlive (x, y) world 
    | (x, y) `elem` world = ln `elem` [2,3]
	| otherwise = ln == 3
    where ln = (liveNeighbours (x,y) world)

min_x world = (minimum $ fst $ unzip world) - 1
max_x world = (maximum $ fst $ unzip world) + 1
min_y world = (minimum $ snd $ unzip world) - 1
max_y world = (maximum $ snd $ unzip world) + 1

progress world = [(x,y) | x <- [min_x world..max_x world], y <- [min_y world..max_y world], isAlive (x, y) world]

ch (x,y) world  
    | isAlive (x,y) world = "*"
    | otherwise = "."
	
br (x,y) world  
    | x == min_x world = "\n"
    | otherwise = ""
	
print_world world = sequence_ [putStr (br (x,y) world) ++ (ch (x,y) world) | x <- [min_x world..max_x world], y <- [min_y world..max_y world]]
--display zs = sequence_ [putStrLn (a++" = "++b) | (a,b) <- zs]

-- TESTS	
testLN1 = liveNeighbours (2,2) start_world == 4
testLN2 = liveNeighbours (1,2) start_world == 3
testLN3 = liveNeighbours (2,1) start_world == 2
testLN4 = liveNeighbours (1,3) start_world == 1
testLN5 = liveNeighbours (3,3) start_world == 0

testAlive0 = isAlive(1,1) start_world == True
testAlive1 = isAlive(2,2) start_world == False
testAlive2 = isAlive(1,3) start_world == False
testAlive3 = isAlive(0,2) start_world == True

testProgress0 = progress start_world == end_world
