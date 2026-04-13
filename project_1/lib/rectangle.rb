class Rectangle
  def initialize(input: $stdin)
    puts "Enter the length:"
    @length = input.gets.chomp.to_i
    puts "Enter the width:"
    @width = input.gets.chomp.to_i
  end

  def rectangle_type
    return nil unless valid_dimensions?
    if @length == @width
      "You have a Square"
    else
      "You have an Oblong Rectangle"
    end
  end

  private

  def valid_dimensions?
    @length > 0 && @width > 0
  end
end
