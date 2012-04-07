def main(world) {
    main_recurse(world, 1)
}

def main_recurse
main_recurse = { world, count ->
    minX = min_x world
    maxX = max_x world
    minY = min_y world
    maxY = max_y world
    println to_string1(world)
    println "^ ${count}-----------------------------------(${minX},${minY})-(${maxX},${maxY}) = ${(maxX-minX)*(maxY-minY)}"
    main_recurse.trampoline(progress2(world), count + 1)
}.trampoline()

def main_recurse1(world, count) {
    minX = min_x world
    maxX = max_x world
    minY = min_y world
    maxY = max_y world
    println to_string1(world)
    println "^ ${count}-----------------------------------(${minX},${minY})-(${maxX},${maxY}) = ${(maxX-minX)*(maxY-minY)}"
    main_recurse1(progress2(world), count + 1)
}

def to_string1(world) {
    def res = ""
    all_cells_sorted_by_row(world).each { x, y ->
        if (x == min_x(world) && y != min_y(world)) res += "\n"
        res += ([x, y] in world) ? "*" : "."
    }
    res
}

def to_string2(world) {
    minX = min_x world
    maxX = max_x world
    minY = min_y world
    maxY = max_y world
    def res = new StringBuilder()
    for (int y = minY; y <= maxY; y++)
        for (int x = minX; x <= maxX; x++) {
            if (x == minX && y != minY) res += "\n"
            res += ([x, y] in world) ? "*" : "."
        }
    res.toString()
}
 
def progress1(world) {
    all_cells_sorted_by_row(world).findAll { x, y -> will_live([x, y], world) }
}
 
def progress2(world) {
    def result = []
    for (int y = minY; y <= maxY; y++)
        for (int x = minX; x <= maxX; x++)
            if (will_live([x, y], world)) result << [x, y]
    result
}
 
def all_cells_sorted_by_row(world) {
    def xs = min_x(world)..max_x(world)
    def ys = min_y(world)..max_y(world)
    [xs, ys].combinations()
}
 
def min_y(world) { world.inject(world[0][0]) { res, tuple -> [tuple[1], res].min() } - 1 }
 
def max_y(world) { world.inject(world[0][0]) { res, tuple -> [tuple[1], res].max() } + 1 }
 
def min_x(world) { world.inject(world[0][0]) { res, tuple -> [tuple[0], res].min() } - 1 }
 
def max_x(world) { world.inject(world[0][0]) { res, tuple -> [tuple[0], res].max() } + 1 }
 
def will_live(cell, world) {
    if (cell in world) alive_neighbours(cell, world) in [2, 3]
    else alive_neighbours(cell, world) == 3
}
 
def alive_neighbours(cell, world) {
    offsets = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
    offsets.findAll { x, y -> [cell.first() + x, cell.last() + y] in world }.collect { x, y -> [cell.first() + x, cell.last() + y] }.size()
}
 
// EXAMPLE WORLDS
def glider() { [[2, 1], [3, 2], [1, 3], [2, 3], [3, 3]] }
def acorn() { [[2, 1], [4, 2], [1, 3], [2, 3], [5, 3], [6, 3], [7, 3]] }
 
main_recurse(acorn(), 1)