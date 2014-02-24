require 'ruby-processing'

class Centroid
  attr_accessor :vector, :size, :color

  def initialize vector, size, color
    @vector, @size, @color = vector, size, color
  end
end

class ColoredPoints < Processing::App

  def setup
    size 500, 500
    smooth
    centroid_size = 10
    @points_size = 5

    @centroids = []
    15.times do
      @centroids << Centroid.new(PVector.new(rand(width), rand(height)), centroid_size, [rand(255), rand(255), rand(255)])
    end

    @points = []
    100.times do
      @points << PVector.new(rand(width), rand(height))
    end

    PVector.public_methods.sort.each {|m| puts m}
  end

  def draw
    background 200
    groups = {}
    stroke(0)
    fill(0)
    @points.each do |p|
      closest = get_closest(p, @centroids)
      groups[closest] = [] unless groups.has_key?(closest)
      groups[closest] << p
      stroke(closest.color[0], closest.color[1], closest.color[2])
      fill(closest.color[0], closest.color[1], closest.color[2])
      ellipse(p.x, p.y, @points_size, @points_size)
    end

    @centroids.each do |c|
      if groups.has_key?(c)
        x = groups[c].inject(0) {|sum, p| sum += p.x}
        x /= groups.size
        y = groups[c].inject(0) {|sum, p| sum += p.y}
        y /= groups.size
        direction = PVector.sub(PVector.new(c.vector.x, c.vector.y), PVector.new(x, y))

        direction.normalize
        c.vector.sub(direction)
      end
      stroke(0)
      fill(c.color[0], c.color[1], c.color[2])
      ellipse(c.vector.x, c.vector.y, c.size, c.size)
    end
  end

  def get_closest point, centroids
    closest_v= PVector.new(width*2, height*2)
    closest = nil

    centroids.each do |c|
      centroid_v = PVector.new(c.vector.x, c.vector.y)
      if point.dist(centroid_v) < point.dist(closest_v)
        closest_v = centroid_v
        closest = c
      end
    end

    closest
  end

end

ColoredPoints.new :title => "Colored Points"
