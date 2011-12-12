require 'test/unit'

def main(world)
  main_recurse(world, 1)
end

def main_recurse(world, count)
  puts to_string world
  puts "^ #{count}-----------------------------------(#{min_x world},#{min_y world})-(#{max_x world},#{max_y world})"
  main_recurse progress(world), count+1
end

def to_string(world)
  res = ""
  all_cells_sorted_by_row(world).each do |(x,y)|
    res << "\n" if (x == min_x(world)) && (y != min_y(world))
    res << (world.include?([x,y]) ? "*" : ".")
  end
  res  
end

def progress(world)
  all_cells_sorted_by_row(world).select { |(x,y)| will_live [x,y], world }
end

def all_cells_sorted_by_row(world)
  xs = ((min_x world)..(max_x world)).to_a
  ys = ((min_y world)..(max_y world)).to_a
  xs.product(ys).sort! { |(x1,y1),(x2,y2)| y1 < y2 ? -1 : (y1 > y2 ? 1 : (x1 <=> x2)) }
end

def min_y(world)
  world.reduce(world[0][0]) { |res, (x,y)| [y, res].min } -1
end

def max_y(world)
  world.reduce(world[0][0]) { |res, (x,y)| [y, res].max } +1
end

def min_x(world)
  world.reduce(world[0][0]) { |res, (x,y)| [x, res].min } -1
end

def max_x(world)
  world.reduce(world[0][0]) { |res, (x,y)| [x, res].max } +1
end

def will_live(cell, world)
  if world.include? cell 
    [2,3].include? alive_neighbours(cell, world) 
  else
    alive_neighbours(cell, world) == 3
  end
end

def alive_neighbours(cell, world)
  offsets = [[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]]
  offsets.select { |(x,y)| world.include? [cell.first+x, cell.last+y] }.map { |(x,y)| [cell.first+x, cell.last+y] }.count
end


############ EXAMPLE WORLDS ############################################

def glider
  [[2,1],[3,2],[1,3],[2,3],[3,3]]
end

def acorn
  [[2,1],[4,2],[1,3],[2,3],[5,3],[6,3],[7,3]]
end


########### TESTS #######################################################

class TestGameOfLife < Test::Unit::TestCase
    def test_alive_neighbours
      test_world = [[1,1],[1,2],[2,2],[1,3],[3,2]]
      assert_equal 4, alive_neighbours([2,2], test_world)
      assert_equal 3, alive_neighbours([0,2], test_world)
      assert_equal 1, alive_neighbours([3,2], test_world)
      assert_equal 0, alive_neighbours([4,4], test_world)
    end

    def test_will_live
      test_world = [[1,1],[1,2],[2,2],[1,3],[3,2]]
      assert_equal false, will_live([2,2], test_world)
      assert_equal true, will_live([0,2], test_world)
      assert_equal false, will_live([3,2], test_world)
      assert_equal false, will_live([2,1], test_world)
      assert_equal false, will_live([2,3], test_world)
      assert_equal false, will_live([4,4], test_world)
    end

    def test_progress
      test_world = [[1,1],[1,2],[2,2],[1,3],[3,2]]
      assert_equal [[1,1],[0,2],[1,2],[1,3]], progress(test_world)
    end

    def test_min_max
      test_world = [[1,1],[1,2],[2,2],[1,3],[3,2]]
      assert_equal 0-1, min_x([[1,1],[0,2],[1,3]])
      assert_equal -1-1, min_y([[1,1],[0,2],[1,3],[0,-1]])
      assert_equal 1-1, min_y([[2,1],[4,2],[1,3],[2,3],[5,3],[6,3],[7,3]])
      assert_equal 1+1, max_x([[1,1],[0,2],[1,3]])
      assert_equal 3+1, max_y([[1,1],[0,2],[1,3],[0,-1]])
    end

    def test_print
      assert_equal "...\n.*.\n...", to_string([[1,1]])
    end
end
