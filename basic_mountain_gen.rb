class Line
  attr_reader :from, :to
  def initialize(from, to)
    @from = from
    @to = to
  end
end

def setup
  size(600, 600)
  @r = height/2
  from_y = random(height/2) + height/2
  to_y = random(height/2) + height/2
  @lines = [Line.new(PVector.new(0, from_y), PVector.new(width, to_y))]
end

def draw
  background(110, 140, 220)

  fill(75, 110, 10)
  begin_shape
  vertex(0, height)
  @lines.each do |line|
    from = line.from
    to = line.to
    vertex(from.x, from.y)
    vertex(to.x, to.y)
  end
  vertex(width, height)
  end_shape(CLOSE)
end

def mouse_pressed
  generate if @r > 1
end

def generate
  new_lines = []
  @lines.each do |line|
    mid_y = ((line.from.y + line.to.y) / 2) + random(-@r, @r/3)
    mid_x = (line.from.x + line.to.x) / 2
    mid_point = PVector.new(mid_x, mid_y)
    new_lines << Line.new(line.from, mid_point)
    new_lines << Line.new(mid_point, line.to)
  end
  @lines = new_lines
  @r /= 1.8
end
