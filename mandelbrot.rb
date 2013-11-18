require 'ruby-processing'
require 'complex'

class Mandelbrot < Processing::App

  def setup
    size(400, 400)

    @step = 4/400.to_f
    @infinity = 20
  end

  def draw
    load_pixels
    i = -2
    (0...width).each do |x|
       j = -2
      (0...height).each do |y|
        c = Complex(i, j)
        z = Complex(0, 0)
        k = 0

        while (z.abs < 2 && k < @infinity) do
          z = z**2 + c
          k += 1
        end

        pixels[y*width + x] = color(0, 0, map(k, 0, 20, 0, 255))
        j += @step
      end
      i += @step
    end
    update_pixels
  end

end
