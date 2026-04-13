class Triangle
  def initialize(input: $stdin)
    puts "Enter side A:"
    @side_a = input.gets.chomp.to_i
    puts "Enter side B:"
    @side_b = input.gets.chomp.to_i
    puts "Enter side C:"
    @side_c = input.gets.chomp.to_i
  end

  def triangle_type
    return "Not a valid triangle" unless valid_sides?
    if equilateral?
      "You have an equilateral triangle"
    elsif isosceles?
      "You have an isosceles triangle"
    elsif scalene?
      "You have a scalene triangle"
    else
      "Unidentified triangle"
    end
  end

  private

  def valid_sides?
    return false if @side_a <= 0 || @side_b <= 0 || @side_c <= 0
    (@side_a + @side_b > @side_c) && (@side_a + @side_c > @side_b) && (@side_b + @side_c > @side_a)
  end

  def equilateral?
    @side_a == @side_b && @side_b == @side_c
  end

  def isosceles?
    @side_a == @side_b || @side_a == @side_c || @side_b == @side_c
  end

  def scalene?
    @side_a != @side_b && @side_a != @side_c && @side_b != @side_c
  end
end
