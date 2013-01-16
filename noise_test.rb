require 'ruby-processing'

class NoiseTest < Processing::App

  def setup
  	size(600, 250)
  	background(0)

  	@tx = 0
  	@ty = 1000
  end

  def draw
  	background(0)
    noise_x = noise(@tx)
    noise_y = noise(@ty)
    x = map(noise_x, 0, 1, 0, @width)
    y = map(noise_y, 0, 1, 0, @height)
    ellipse(x, y, 16, 16)
    @tx += 0.01
    @ty += 0.01
  end	
end

NoiseTest.new