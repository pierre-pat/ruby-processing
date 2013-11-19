require 'complex'

def setup
  size(400, 400)
  smooth
  @step = 4/width.to_f
  @infinity = 200
  @c = Complex(-0.1, 0.651)
  @changed = true
  @exp = 2
end

def draw
  if @changed
    background(0)
    load_pixels
    i = -2

    (0...width).each do |x|
      j = -2
      (0...height).each do |y|
        z = Complex(i + x*@step, j + y*@step)
        k = 0

        while (z.abs < 2 && k < @infinity) do
          z = z**@exp + @c
          k += 1
        end

        pixels[y*width + x] = color(0, map(k, 0, @infinity , 0, 255), 0)
        j += @step
      end
      i += @step
    end
    update_pixels

    fill(255)
    text("Equation: Z^" + @exp.to_s + " + C", 10, height-65)
    text("C = " + @c.to_s, 10, height-50)
    text("q/a to Up/Down the real part of 0.01", 10, height-35)
    text("w/s to Up/Down the imaginery part 0.01", 10, height-20 )
    text("Enter a number to change the exponent.", 10, height-5)

    @changed = false
  end
end

def key_typed
  case key
    when 'q'
      @c += Complex.new(0.01, 0)
      @changed = true
    when 'a'
      @c -= Complex.new(0.01, 0)
      @changed = true
    when 'w'
      @c += Complex.new(0.01, 0)
      @changed = true
    when 's'
      @c -= Complex.new(0.01, 0)
      @changed = true
    when '0'..'9'
      @exp = key.to_i
      @changed = true
  end
end
