require 'ruby-processing'

class Particle
  include Processing::Proxy

  def initialize l
    @location = l.get
    @velocity = PVector.new((rand * 2 - 1), (rand * 2-1))
    @lifespan = 250
    @color = color(rand(255), rand(255), rand(255))
    @acceleration = PVector.new(0, 0)
  end

  def update
    @velocity.add(@acceleration)
    @location.add(@velocity)
    @lifespan -= 2
    @acceleration.mult(0)
  end

  def apply_force(f)
    @acceleration.add(f)
  end

  def display
    push_matrix
    fill(@color, @lifespan)
    ellipse(@location.x, @location.y, 10, 10)
    pop_matrix
  end

  def is_dead
    @lifespan <= 0
  end
end

class ParticleSystem
  include Processing::Proxy

  def initialize
  	@particles = []
  end

  def add_particle(p)
    @particles << p
  end

  def apply_force(f)
    @particles.each do |p|
      p.apply_force(f)
    end
  end

  def display
    push_matrix
    @particles.each do |p|
  	  p.display
    end
    pop_matrix
  end

  def update
    @particles.each do |p|
      p.update
    end

    @particles.delete_if { |p| p.is_dead }
  end
end

class ParticleSystemDrawer < Processing::App

  def setup
    size(600, 300)
    @ps = ParticleSystem.new
    @gravity = PVector.new(0, 0.05)
    @wind = PVector.new(1, 0)
  end

  def draw
    background(250)
    @ps.add_particle(Particle.new(PVector.new(width/2, 50)))

    @ps.apply_force(@gravity)
    @ps.update
    @ps.display
  end

  def mouse_pressed
    @ps.apply_force(@wind)
  end
end



ParticleSystemDrawer.new
