require 'ruby-processing'

class LSystem
  include Processing::Proxy

  attr_reader :axiom

  def initialize(start, grammar, rules, length)
    @axiom = [start]
    @grammar = grammar
    @rules = rules
    @length = length
  end

  def generate
    new_axiom = []

    @axiom.each do |letter|
      if @grammar[letter]
        @grammar[letter].each_char { |l| new_axiom << l }
      else
        new_axiom << letter
      end
    end
    @axiom = new_axiom

    @length /= 2
  end

  def draw
    @axiom.each do |letter|
      @rules[letter].call(@length)
    end
  end

end

class SystemSketch < Processing::App

  def setup
    size(400, 400)
    # rules = {}
    # rules['F'] = "FGF"
    # rules['G'] = "GGG"
    gramar = { 'F' => 'FF+[+F-F-F]-[-F+F+F]' }
    rules = {
      'F' => ->(length){ line(0, 0, 0, length);  translate(0, length) },
      'G' => ->(length){ translate(0, length) },
      '+' => ->(radians){ rotate(radians(25)) },
      '-' => ->(radians){ rotate(-radians(25)) },
      '[' => ->(m=nil){ push_matrix },
      ']' => ->(m=nil){ pop_matrix }
    }
    @lsystem = LSystem.new('F', gramar, rules, width/4 )
  end

  def mouse_pressed
    @lsystem.generate
  end

  def draw
    background(255)
    translate(width/2, height)
    rotate(radians(180))

    @lsystem.draw
  end
end
