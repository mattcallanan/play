def main(world) {
    main_recurse(world, 1)
}
 
def main_recurse(world, count) {
    minX = min_x world
    maxX = max_x world
    minY = min_y world
    maxY = max_y world
    println to_string(world)
    println "^ ${count}-----------------------------------(${minX},${minY})-(${maxX},${maxY}) = ${(maxX-minX)*(maxY-minY)}"
    main_recurse progress(world), count + 1
}
 
def to_string(world) {
    def res = ""
    all_cells_sorted_by_row(world).each { x, y ->
        if (x == min_x(world) && y != min_y(world)) res += "\n"
        res += ([x, y] in world) ? "*" : "."
    }
    res
}
 
def progress(world) {
    all_cells_sorted_by_row(world).findAll { x, y -> will_live([x, y], world) }
}
 
def all_cells_sorted_by_row(world) {
    def xs = min_x(world)..max_x(world)
    def ys = min_y(world)..max_y(world)
    def combos = [xs, ys].combinations()
    combos.sort{ tuple1, tuple2 ->
        def (x1, y1) = tuple1
        def (x2, y2) = tuple2
        y1 < y2 ? -1 : (y1 > y2 ? 1 : (x1 <=> x2)) }
    combos
}
 
def min_y(world) {
    world.inject(world[0][0]) { res, tuple -> [tuple[1], res].min() } - 1
}
 
def max_y(world) {
    world.inject(world[0][0]) { res, tuple -> [tuple[1], res].max() } + 1
}
 
def min_x(world) {
    world.inject(world[0][0]) { res, tuple -> [tuple[0], res].min() } - 1
}
 
def max_x(world) {
    world.inject(world[0][0]) { res, tuple -> [tuple[0], res].max() } + 1
}
 
def will_live(cell, world) {
    if (cell in world) alive_neighbours(cell, world) in [2, 3]
    else alive_neighbours(cell, world) == 3
}
 
def alive_neighbours(cell, world) {
    offsets = [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]]
    offsets.findAll { x, y -> [cell.first() + x, cell.last() + y] in world }.collect { x, y -> [cell.first() + x, cell.last() + y] }.size()
}
 
// EXAMPLE WORLDS
 
def glider() {
    [[2, 1], [3, 2], [1, 3], [2, 3], [3, 3]]
}
 
def acorn() {
    [[2, 1], [4, 2], [1, 3], [2, 3], [5, 3], [6, 3], [7, 3]]
}
 
// TESTS
 
class TestGameOfLife extends GroovyTestCase {
    def test_alive_neighbours() {
        def test_world = [[1, 1], [1, 2], [2, 2], [1, 3], [3, 2]]
        assertEquals 4, alive_neighbours([2, 2], test_world)
        assertEquals 3, alive_neighbours([0, 2], test_world)
        assertEquals 1, alive_neighbours([3, 2], test_world)
        assertEquals 0, alive_neighbours([4, 4], test_world)
    }
 
    def test_will_live() {
        def test_world = [[1, 1], [1, 2], [2, 2], [1, 3], [3, 2]]
        assertEquals false, will_live([2, 2], test_world)
        assertEquals true, will_live([0, 2], test_world)
        assertEquals false, will_live([3, 2], test_world)
        assertEquals false, will_live([2, 1], test_world)
        assertEquals false, will_live([2, 3], test_world)
        assertEquals false, will_live([4, 4], test_world)
    }
 
    def test_progress() {
        def test_world = [[1, 1], [1, 2], [2, 2], [1, 3], [3, 2]]
        assertEquals([[1, 1], [0, 2], [1, 2], [1, 3]], progress(test_world))
    }
 
    def test_min_max() {
        assertEquals 0 - 1, min_x([[1, 1], [0, 2], [1, 3]])
        assertEquals ((- 1 - 1), min_y([[1, 1], [0, 2], [1, 3], [0, -1]]))
        assertEquals 1 - 1, min_y([[2, 1], [4, 2], [1, 3], [2, 3], [5, 3], [6, 3], [7, 3]])
        assertEquals 1 + 1, max_x([[1, 1], [0, 2], [1, 3]])
        assertEquals 3 + 1, max_y([[1, 1], [0, 2], [1, 3], [0, -1]])
    }
 
    def test_print() {
        assertEquals "...\n.*.\n...", to_string([[1, 1]])
    }
}
 
main acorn()