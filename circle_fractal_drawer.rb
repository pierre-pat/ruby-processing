require 'ruby-processing'

class CircleFractalDrawer < Processing::App

  def setup
  	size(600, 600)
  	background(0)
  	color(0, 250, 0)
  end

  def draw
  	background(0)
  	no_fill
  	stroke(0, 255, 0)
  	draw_circle(width/2, height/2, 300)
  end

  def draw_circle(x, y, r)
  	ellipse(x, y, r, r)
  	draw_circle(x+r/2, y, r/2) if (r > 5)
  	draw_circle(x-r/2, y, r/2) if (r > 5)
  	draw_circle(x, y-r/2, r/2) if (r > 5)
  end

end