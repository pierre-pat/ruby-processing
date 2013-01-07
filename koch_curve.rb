require 'ruby-processing'

class Point
  attr_accessor :x, :y

  def initialize x, y
    @x, @y = x, y
  end

end

class KochLine

  attr_accessor :start_pt, :end_pt

  def initialize start_pt, end_pt
    @start_pt, @end_pt = start_pt, end_pt
  end

end

class KochCurve
  attr_accessor :koch_lines, :start_pt, :end_pt

  def initialize
    @start_pt = Point.new 10, 240
    @end_pt = Point.new 590, 240
    @koch_lines = [KochLine.new(@start_pt, @end_pt)]
  end

  def step_up
    new_lines = Array.new

    @koch_lines.each do |line|
      p1 = one_third(line)
      p2 = middle(line)
      p3 = two_third(line)

      new_lines << KochLine.new(line.start_pt, p1)
      new_lines << KochLine.new(p1, p2)
      new_lines << KochLine.new(p2, p3)
      new_lines << KochLine.new(p3, line.end_pt)
    end

    @koch_lines = new_lines
  end

  def step_down
    return if @koch_lines.size == 1

    new_lines = Array.new
    start = @koch_lines[0].start_pt
    (3..@koch_lines.size).step(4) do |i|
      new_lines << KochLine.new(start, @koch_lines[i].end_pt)
      start = @koch_lines[i].end_pt
    end

    @koch_lines = new_lines
  end

  def one_third line
    x = line.start_pt.x + (line.end_pt.x - line.start_pt.x) / 3.to_f;
    y = line.start_pt.y + (line.end_pt.y - line.start_pt.y) / 3.to_f;
    Point.new x, y
  end

  def middle line
    x = line.start_pt.x + 0.5 * (line.end_pt.x - line.start_pt.x) + (Math::sin(radians(60)) * (line.end_pt.y - line.start_pt.y)) / 3.to_f;
    y = line.start_pt.y + 0.5 * (line.end_pt.y - line.start_pt.y) - (Math::sin(radians(60)) * (line.end_pt.x - line.start_pt.x)) / 3.to_f;
    Point.new x, y
  end

  def two_third line
    x = line.start_pt.x + 2 * (line.end_pt.x - line.start_pt.x) / 3.to_f;
    y = line.start_pt.y + 2 * (line.end_pt.y - line.start_pt.y) / 3.to_f;
    Point.new x, y
  end

  def radians angle
    angle/180.to_f * Math::PI
  end
end

class KochCurveDrawer < Processing::App

  def setup
    size(600, 250)
    background(0)
    stroke(0, 250, 0)
    smooth

    @koch = KochCurve.new
  end

  def draw
    background(0)
    stroke(0, 250, 0)
     @koch.koch_lines.each do |line|
       line line.start_pt.x, line.start_pt.y, line.end_pt.x, line.end_pt.y
     end
  end

  def mouse_clicked
    if mouse_button == LEFT
      @koch.step_up
    else
      @koch.step_down
    end
  end
end

KochCurveDrawer.new