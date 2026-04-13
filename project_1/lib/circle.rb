class Circle
  def initialize(input: $stdin)
    puts "Enter the circle's radius:"
    @radius = input.gets.chomp.to_i
  end

  def circle_size
    if valid_radius?
      [diameter?, area?]
    end
  end

  def diameter?
    diameter = @radius * 2
    "Your diameter is #{diameter}"
  end

  def area?
    area = (Math::PI * @radius**2).round(2)
    "Your area #{area}"
  end

  private

  def valid_radius?
    @radius > 0
  end
end
