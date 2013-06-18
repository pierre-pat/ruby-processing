require 'ruby-processing'

class SinCosDrawer < Processing::App

  def setup
  	size(600, 400)
  	@balls = []
  	@angles = []
  	(0 .. width).step(10).each do |i|
  	  @balls << i
  	  a = map(i, 0, 600, 0, 360)
  	  @angles << a
  	end
  end

  def draw
  	background(255)

  	stroke(0)
  	stroke_weight(1)
  	@balls.each_index do |i|
      fill(120, 100)
  	  y = sin(@angles[i])
  	  y = map(y, -1, 1, 0, height)	
  	  ellipse(@balls[i], y, 30, 30)
  	  
      y = cos(@angles[i])
      y = map(y, -1, 1, 0, height)
      fill(2550, 0, 0, 100)
      ellipse(@balls[i], y, 30, 30)

      @angles[i] += 0.02
  	end
  end
end

SinCosDrawer.new