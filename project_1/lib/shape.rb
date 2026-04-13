require "./lib/triangle"
require "./lib/circle"
require "./lib/rectangle"

class Shape
  def initialize(input: $stdin)
    @input = input
    puts "How many sides does your shape have?"
    @angles = input.gets.chomp.to_i
  end

  def find_shape(angles = @angles)
    case angles
    when 4
      Rectangle.new(input: @input).rectangle_type
    when 3
      Triangle.new(input: @input).triangle_type
    when 0
      Circle.new(input: @input).circle_size
    else
      "No shape exists with that amount of sides"
    end
  end
end
