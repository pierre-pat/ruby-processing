require 'ruby-processing'

class SierpenskiPoints < Processing::App

		A = PVector.new(50, 350)
		B = PVector.new(200, 50)
		C = PVector.new(350, 350)

	def setup
		size(400, 400)
	
		@previous = PVector.new(rand(300), rand(300))
		@iterations = 0
	end

	def draw
		puts "#{@iterations}"
		line(A.x, A.y, B.x, B.y)
		line(B.x, B.y, C.x, C.y)
		line(C.x, C.y, A.x, A.y)
		ellipse(@previous.x, @previous.y, 1, 1)

		r = rand(3)
		@previous = if r < 1 then
									PVector.new((A.x + @previous.x) / 2, (A.y + @previous.y) / 2)
								elsif r < 2 then
									PVector.new((B.x + @previous.x) / 2, (B.y + @previous.y) / 2)
								else
									PVector.new((C.x + @previous.x) / 2, (C.y + @previous.y) / 2)
								end
		@iterations += 1
	end
end