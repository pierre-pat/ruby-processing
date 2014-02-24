require 'ruby-processing'
require 'vehicle'

class ArrivingVehicle < Processing::App
  def setup
    size(500, 500)
    smooth
    @vehicle = Vehicle.new(rand(@width), rand(@height))
  end

  def update
    target = PVector.new(mouse_x, mouse_y)
    @vehicle.arrive(target)

    @vehicle.update
  end

  def draw
    background(50)
    @vehicle.draw

    update
  end
end
