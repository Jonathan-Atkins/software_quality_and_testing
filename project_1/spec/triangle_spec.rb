require "./lib/triangle"

RSpec.describe "Triangle" do
  def build_triangle(a, b, c)
    fake_input = StringIO.new("#{a}\n#{b}\n#{c}\n")
    Triangle.new(input: fake_input)
  end

  it "returns 'Not a valid triangle' for invalid sides" do
    fake_input = StringIO.new("0\n3\n4\n")
    triangle = Triangle.new(input: fake_input)
    expect(triangle.triangle_type).to eq("Not a valid triangle")
  end

  it "exists" do
    expect(build_triangle(3, 4, 5)).to be_an(Triangle)
  end

  it "identifies an equilateral triangle" do
    expect(build_triangle(3, 3, 3).triangle_type).to eq("You have an equilateral triangle")
  end

  it "identifies an isosceles triangle" do
    expect(build_triangle(3, 3, 4).triangle_type).to eq("You have an isosceles triangle")
  end

  it "identifies a scalene triangle" do
    expect(build_triangle(3, 4, 5).triangle_type).to eq("You have a scalene triangle")
  end

  it "returns invalid message for invalid triangle" do
    expect(build_triangle(1, 1, 10).triangle_type).to eq("Not a valid triangle")
  end

  it "returns invalid message when side is zero" do
    expect(build_triangle(0, 4, 5).triangle_type).to eq("Not a valid triangle")
  end

  it "returns invalid message when side is negative" do
    expect(build_triangle(-3, 4, 5).triangle_type).to eq("Not a valid triangle")
  end
end
