require 'ruby-processing'

class NoiseTest2 < Processing::App

  def setup
    size(600, 600)
    @tx = 0
      @ty = 100
  end	

  def draw
    load_pixels
    (0...width).each do |x|
      (0...height).each do |y|
      	noise = noise(@tx, @ty)
      	bright = map(noise, 0, 1, 0, 255)
      	pixels[x+y*width] = color(bright)
    	@ty += 0.1
      end
      @tx += 0.1
    end
    update_pixels

  end


end


NoiseTest2.new