require 'ruby-processing'

class Point
	attr_accessor :x, :y
	def initialize x, y
		@x, @y = x, y
	end
end

class SquareKoch
	attr_accessor :points
	def initialize point, length
		@points = []
		@points << point
		cos1 = length * Math.cos(60)
		sin1 = length * Math.sin(60)
		p2 = Point.new(point.x, point.y - length)
		p3 = Point.new(point.x + length, point.y - length)
		p4 = Point.new(point.x + length, point.y)

		points << p2 << p3 << p4
	end

	def step_up
		new_points = []
		new_points << @points[0]

		@points.each_index do |i|
			from = @points[i]
		  to_idx = i+1
		  to_idx = 0 if to_idx >= @points.size
		  to = @points.at(to_idx)
		  p1, p2, p3, p4 = nil
		  
		  if from.x == to.x
		  	l = get_length to.y, from.y
		  	if from.y > to.y
		  		p1 = Point.new from.x, from.y - l
		  		p2 = Point.new from.x - l, from.y - l
		  		p3 = Point.new from.x - l, from.y - 2*l
		  		p4 = Point.new from.x, from.y - 2*l
		  	else
		  		p1 = Point.new from.x, from.y + l
		  		p2 = Point.new from.x + l, from.y + l
		  		p3 = Point.new from.x + l, from.y + 2*l
		  		p4 = Point.new from.x, from.y + 2*l
		  	end
		  else
		  	l = get_length to.x, from.x
		  	if from.x > to.x
		  		p1 = Point.new from.x - l, from.y
		  		p2 = Point.new from.x - l, from.y + l
		  		p3 = Point.new from.x - 2*l, from.y + l
		  		p4 = Point.new from.x - 2*l, from.y
		  	else
		  		p1 = Point.new from.x + l, from.y
		  		p2 = Point.new from.x + l, from.y - l
		  		p3 = Point.new from.x + 2*l, from.y - l
		  		p4 = Point.new from.x + 2*l, from.y
		  	end
		  end

		  new_points << p1 << p2 << p3 << p4 << to
		  
		end

		@points = new_points[0..new_points.size-2]

	end

	def step_down
    return if @points.size == 4

		new_points = []

		(0...@points.size).step(5) do |i|
			new_points << @points[i]
		end
		@points = new_points

	end

	def get_length a, b
		return (b-a) / 3 if a < b
	  return (a-b) / 3
	end

end

class KochSquareDrawer < Processing::App
	def setup
		size(600,600)
		background(0)
		smooth
		p = Point.new(150, 450)
		@koch = SquareKoch.new(p, 300)
		color_mode RGB, 1.0
	end

	def draw
		background(0)
		stroke(1,0,0)
		beginShape
		@koch.points.each_index do |i|
		  from = @koch.points.at(i)
		  to_idx = i+1
		  to_idx = 0 if to_idx >= @koch.points.size

		  to = @koch.points.at(to_idx)
			line(from.x, from.y, to.x, to.y)
		end
		endShape
	end

	def mouse_clicked
		if mouse_button == LEFT
			@koch.step_up
		else
			@koch.step_down
		end
	end
end

KochSquareDrawer.new