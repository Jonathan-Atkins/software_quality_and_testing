require "./lib/shape"

RSpec.describe "Shape" do
  def build_equilateral
    fake_input = StringIO.new("3\n3\n3\n3\n")
    Shape.new(input: fake_input)
  end

  def build_isosceles
    fake_input = StringIO.new("3\n3\n3\n2\n")
    Shape.new(input: fake_input)
  end

  def build_scalene
    fake_input = StringIO.new("3\n3\n4\n5\n")
    Shape.new(input: fake_input)
  end

  def build_circle
    fake_input = StringIO.new("0\n5\n")
    Shape.new(input: fake_input)
  end

  def build_rectangle
    fake_input = StringIO.new("4\n6\n3")
    Shape.new(input: fake_input)
  end

  it "exists" do
    shape = build_equilateral
    expect(shape).to be_an(Shape)
  end

  it "can determine if shape is a triangle" do
    expect(build_equilateral.find_shape(3)).to eq("You have an equilateral triangle")
    expect(build_isosceles.find_shape(3)).to eq("You have an isosceles triangle")
    expect(build_scalene.find_shape(3)).to eq("You have a scalene triangle")
  end
  it "can determine if shape is a Circle and dimensions" do
    expect(build_circle.find_shape(0)).to eq(["Your diameter is 10", "Your area 78.54"])
  end
  it "can determine if shape is a Square" do
    fake_input = StringIO.new("4\n4\n4\n")
    shape = Shape.new(input: fake_input)
    expect(shape.find_shape(4)).to eq("You have a Square")
  end

  it "can determine if shape is an Oblong Rectangle" do
    fake_input = StringIO.new("4\n6\n3\n")
    shape = Shape.new(input: fake_input)
    expect(shape.find_shape(4)).to eq("You have an Oblong Rectangle")
  end

  it "returns error for unsupported number of sides" do
    fake_input = StringIO.new("5\n")
    shape = Shape.new(input: fake_input)
    expect(shape.find_shape(5)).to eq("No shape exists with that amount of sides")
  end

  it "returns error for unsupported number of sides" do
    fake_input = StringIO.new("5\n")
    shape = Shape.new(input: fake_input)
    expect(shape.find_shape(5)).to eq("No shape exists with that amount of sides")
  end
end
