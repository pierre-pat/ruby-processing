require 'ruby-processing'

class Point
  attr_accessor :x, :y

  def initialize x, y
    @x, @y = x, y
  end
end

class SierpinskiTriangle
	attr_reader :p1, :p2, :p3

	def initialize p1, p2, p3
		@p1, @p2, @p3 = p1, p2, p3
	end

	def split
		triangles = []

		p1 = @p1
		p2 = Point.new((@p1.x+@p2.x)/2, (@p1.y+@p2.y)/2)
		p3 = @p2
		p4 = Point.new((@p2.x+@p3.x)/2, (@p2.y+@p3.y)/2)
		p5 = @p3
		p6 = Point.new((@p1.x+@p3.x)/2, @p1.y)
		triangles << SierpinskiTriangle.new(p1, p2, p6)
		triangles << SierpinskiTriangle.new(p2, p3, p4)
		triangles << SierpinskiTriangle.new(p6, p4, p5)

		triangles
	end
end

class SierpinskiTriangleDrawer < Processing::App

	def setup
	end

	def draw
	end

	def mouse_clicked
	end

end

SierpinskiTriangleDrawer.new	

p1 = Point.new(1, 1)
p2 = Point.new(1, 1)
p3 = Point.new(1, 1)
st = SierpinskiTriangle.new(p1, p2, p3)

st.split