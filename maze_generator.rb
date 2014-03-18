class Cell
  attr_accessor :north, :east, :south, :west
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
    @north = false
    @east = false
    @south = false
    @west = false
  end

  def to_s
    "" << (@north? 'N' : '#') << (@east? 'E' : '#') << (@south? 'S' : '#') << (@west? 'W' : '#')
  end
end

class Maze
  attr_reader :grid
  def initialize(size, cell_size)
    @size = size
    index = Struct.new(:x, :y)
    @north = false
    @east = false
    @south = false
    @east = false

    @cell_size = cell_size

    generate
  end

  def generate
    @grid = Array.new(@size) do |i|
      Array.new(@size) do |j|
        Cell.new(i, j)
      end
    end

    visited = []
    current = grid[0][0]
    to_visit = []

    while current
      visited << current
      cell = get_neighbor(current, visited)

      if cell
        open_path(current, cell)
        to_visit << current
        current = cell
      else
        current = to_visit.shift
      end
    end
  end

  def get_neighbor(current, visited)
    x = current.x
    y = current.y
    cells = []
    cells << @grid[x-1][y] if current.x > 0 and not visited.include?(@grid[x-1][y])
    cells << @grid[x][y+1] if current.y < @grid.size-1 and not visited.include?(@grid[x][y+1])
    cells << @grid[x+1][y] if current.x < @grid.size-1 and not visited.include?(@grid[x+1][y])
    cells << @grid[x][y-1] if current.x > 0 and not visited.include?(@grid[x][y-1])
    cells.size > 0 ? cells.shuffle[0] : nil
  end

  def open_path(current, cell)
    if current.x < cell.x
      current.south = true
      cell.north = true
    end
    if current.y < cell.y
      current.east = true
      cell.west = true
    end
    if current.x > cell.x
      current.north = true
      cell.south = true
    end
    if current.y > cell.y
      current.west = true
      cell.east = true
    end
  end

  def print_maze
    @grid.each do |row|
      row.each do |cell|
        print cell
        print '|'
      end
      puts ''
    end
  end

  def display
    stroke_weight(1)
    fill(120)
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        push_matrix
        translate(j*@cell_size, i*@cell_size)
        no_stroke
        rect(0, 0, @cell_size, @cell_size)

        stroke(0)
        line(0, 0, @cell_size, 0) unless cell.north
        line(@cell_size, 0, @cell_size, @cell_size) unless cell.east
        line(0, @cell_size, @cell_size, @cell_size) unless cell.south
        line(0, 0, 0, @cell_size) unless cell.west
        pop_matrix
      end
    end
  end
end

def setup
  size(400, 400)
  @maze = Maze.new(width/10, width/(width/10))
end

def draw
  background(255)
  @maze.display
end

def mouse_pressed
  @maze.generate
end
