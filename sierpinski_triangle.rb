require 'ruby-processing'

class SierpinskiTriangle
	attr_reader :p1, :p2, :p3

	def initialize p1, p2, p3
		@p1, @p2, @p3 = p1, p2, p3
	end

	def split
		triangles = []

		p1 = @p1
		p2 = PVector.new((@p1.x+@p2.x)/2, (@p1.y+@p2.y)/2)
		p3 = @p2
		p4 = PVector.new((@p2.x+@p3.x)/2, (@p2.y+@p3.y)/2)
		p5 = @p3
		p6 = PVector.new((@p1.x+@p3.x)/2, @p1.y)
		triangles << SierpinskiTriangle.new(p1, p2, p6)
		triangles << SierpinskiTriangle.new(p2, p3, p4)
		triangles << SierpinskiTriangle.new(p6, p4, p5)

		triangles
	end
end

class SierpinskiTriangleDrawer < Processing::App

	def setup
		size(600, 600)
	    background(0)
	    stroke(0, 250, 0)
	    smooth
		fill(0, 250, 0)

	    p1 = PVector.new(10, 580)
	    p2 = PVector.new(300, 10)
	    p3 = PVector.new(590, 580)
	    @triangles = []
	    @triangles << SierpinskiTriangle.new(p1, p2, p3)
	end

	def draw
		background(0)
		@triangles.each do |t|
			triangle(t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y)
		end
	end

	def mouse_clicked
		new_triangles = []
		if mouse_button == LEFT
			@triangles.each do |t|
				t.split.each{ |i| new_triangles << i }
			end
		else
			return @triangles if @triangles.size == 1
			(0...@triangles.size).step(3) do |i|
				p1 = @triangles[i].p1
				p2 = @triangles[i+1].p2
				p3 = @triangles[i+2].p3
				new_triangles << SierpinskiTriangle.new(p1, p2, p3)
			end
		end

		@triangles = new_triangles
		puts "number of triangles: #{@triangles.size}"
	end

end

SierpinskiTriangleDrawer.new	
