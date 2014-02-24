def setup
  size(500, 300)
  smooth
  frame_rate(30)
  background(255)
  stroke_weight(1)
  no_fill

  @angnoise = random(10)
  @radiusnoise = random(10)
  @xnoise = random(10)
  @ynoise = random(10)
  @angle = -PI/2
  @stroke_col = 254
  @stroke_change = -1
end

def draw
  @radiusnoise += 0.005
  @radius = (noise(@radiusnoise) * 550) + 1

  @angnoise += 0.005
  @angle += (noise(@angnoise) * 6) -3
  @angle -= 360 if @angle > 360
  @angle += 360 if @angle < 0

  @xnoise += 0.01
  @ynoise += 0.01

  centerx = @width/2 + (noise(@xnoise) * 100) - 50
  centery = @height/2 + (noise(@ynoise) * 100) - 50

  rad = radians(@angle)
  x1 = centerx + (@radius * cos(rad))
  y1 = centery + (@radius * sin(rad))

  opprad = rad + PI
  x2 = centerx + (@radius * cos(opprad))
  y2 = centery + (@radius * sin(opprad))

  @stroke_col += @stroke_change
  @stroke_change = -1 if @stroke_col > 254
  @stroke_change = 1 if @stroke_col < 0

  stroke(@stroke_col, 60)
  line(x1, y1, x2, y2)
end
