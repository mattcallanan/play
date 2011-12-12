class Cell
  constructor: (@x, @y) ->
  
alive = (cell, world) -> 
  aliveNeighbours cell world

aliveNeighbours (cell, world) ->
  live = (n for n in [north cell world, northeast cell world, east cell world, southeast cell world, south cell world, southwest cell world, west cell world, northwest cell world] when n == true)
  live.length
  
north      (cell, world) -> world.indexOf(new Cell {cell.x, cell.y-1}) != -1
northeast  (cell, world) -> world.indexOf(new Cell {cell.x+1, cell.y-1}) != -1
east       (cell, world) -> world.indexOf(new Cell {cell.x+1, cell.y}) != -1
southeast  (cell, world) -> world.indexOf(new Cell {cell.x+1, cell.y+1}) != -1
south      (cell, world) -> world.indexOf(new Cell {cell.x, cell.y+1}) != -1
southwest  (cell, world) -> world.indexOf(new Cell {cell.x-1, cell.y+1}) != -1
west       (cell, world) -> world.indexOf(new Cell {cell.x-1, cell.y}) != -1
northwest  (cell, world) -> world.indexOf(new Cell {cell.x-1, cell.y-1}) != -1
  
alert alive (new Cell {1, 1}, [(new Cell {0, 0}),
                               (new Cell {1, 0}),
                               (new Cell {0, 1})])
							   
							   






							   
  count = 0
  #shortNames = (name for name in ['aaaaaaa','b','c'] when name.length < 5)
  for (int y = -1; y <= 1; y++) {
      for (int x = -1; x <= 1; x++) {
		  if (!(x == 0) && (y == 0)) {
		     if (world.contains(new Cell {cell.x + x, cell.y + y})) count++
		  }
	  }
   }
   count
