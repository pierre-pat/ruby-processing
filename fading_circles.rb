class Circle
  attr_reader :location, :radius, :alive
  def initialize
    @radius = random(60) + 10
    @location = PVector.new(random(width - @radius), random(height - @radius))
    @xnoise = random(100)
    @ynoise = random(100)
    @color = color(rand(255), rand(255), rand(255))
    @alpha = rand(255)
    @alive = true
  end

  def draw
    fill(@color, @alpha)
    ellipse(@location.x, @location.y, @radius*2, @radius*2)
    no_fill
    stroke_width(2)
    stroke(0)
    ellipse(@location.x, @location.y, 5, 5)
  end

  def update(circles)
    circles.each do |c|
      if c != self
        @alpha -= 1 if intersect(c)
      end
    end

    @location.x += map(noise(@xnoise), 0, 1, -1, 1)
    @location.y += map(noise(@ynoise), 0, 1, -1, 1)
    @xnoise += 0.01
    @ynoise += 0.01

    @alive = false if @location.x < 0 or @location.x > width or @location.y < 0 or @location.y > height or @alpha <= 0
  end

  private
  def intersect(circle)
    @location.dist(circle.location) < @radius + circle.radius
  end
end

def setup
  size(500, 500)
  smooth
  @circles = []
end

def draw
  background(150)
  @circles.each do |c|
    c.draw
    c.update(@circles)
  end

  @circles.delete_if{ |c| !c.alive }
end

def mouse_clicked
  10.times { @circles << Circle.new }
end
