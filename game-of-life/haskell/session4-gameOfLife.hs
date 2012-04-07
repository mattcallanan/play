

progress world = [(x,y)|y <- [minY world..maxY world], x <- [minX world..maxX world], alive (x,y) world]

minX world = (minimum (fst (unzip world))) -1 
minY world = (minimum (snd (unzip world))) - 1
maxX world = (maximum (fst (unzip world))) + 1
maxY world = (maximum (snd (unzip world))) + 1

alive (x,y) world 
   | (elem (x,y) world) && (aliveNeighbours (x,y) world) == 2 = True
   | (elem (x,y) world) && (aliveNeighbours (x,y) world) == 3 = True
   | (not (elem (x,y) world)) && (aliveNeighbours (x,y) world) == 3 = True
   | otherwise = False
   
aliveNeighbours (pointX, pointY) world = length 
    [(pointX + x,pointY + y) | x <- [-1..1], y <-[-1..1], not (x == 0 && y == 0), elem (pointX + x, pointY + y) world]
