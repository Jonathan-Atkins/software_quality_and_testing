require "./lib/circle"

RSpec.describe "Circle" do
  before do
    @circle = Circle.new(input: StringIO.new("5\n"))
  end
  it "can be created" do
    expect(@circle).to be_a(Circle)
  end
  it "can determine the diameter of a circle" do
    expect(@circle.diameter?).to eq("Your diameter is 10")
  end
  it "can determine the area of a circle" do
    expect(@circle.area?).to eq("Your area 78.54")
  end
  it "returns nil for invalid (zero) radius" do
    circle = Circle.new(input: StringIO.new("0\n"))
    expect(circle.circle_size).to be_nil
  end
end
