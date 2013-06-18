require 'ruby-processing'

class TreeDrawer < Processing::App

	def setup
		size width, height
		@original_length = 180
		@color = ["FF", "00", "00"]
		color_mode RGB, 1.0
		smooth
	end

	def draw
		background 0

		color = get_color
		red = color[0..1]
		green = color[2..3]
		blue = color[4..5]
		stroke @color[0].to_i(16), @color[1].to_i(16), @color[2].to_i(16)
		translate width / 2, height
		line 0, 0, 0, -@original_length
		translate 0, -@original_length
		angle = (mouse_x.to_f / width.to_f) * 160.to_f 
		@rad = radians(angle)
		branch @original_length
	end

	def branch h
		h *= 0.66
		return if h < 2
		
		push_matrix
		rotate @rad
		
		color = get_color

		stroke(color[0], color[1], color[2])

    	line 0,0, 0, -h
		translate 0, -h
		branch h
		pop_matrix

		push_matrix
		rotate -@rad
		line 0,0, 0, -h
		translate 0, -h
		branch h
		pop_matrix
	end

	def get_color
		y = mouse_y > 0 ? mouse_y : 250
		c = "FFFFFF".to_i(16) / height.to_f * y
		c = c.to_i.to_s(16)
		while c.size < 6
			c += '0'
		end
		puts "#{c[0..1]}, #{c[2..3]}, #{c[4..5]}}"
		[c[0..1].to_i, c[2..3].to_i, c[4..5].to_i]
	end

	def mouse_clicked
		if mouse_button == LEFT
			@color = get_color
			puts "color"
		end
	end
end

TreeDrawer.new :width => 650, :height => 650