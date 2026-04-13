require './lib/rectangle'

describe Rectangle do
  def build_square
    fake_input = StringIO.new("4\n4\n4\n")
    Rectangle.new(input: fake_input)
  end

  def build_oblong
    fake_input = StringIO.new("4\n6\n3\n")
    Rectangle.new(input: fake_input)
  end

  it "identifies a square" do
    rect = build_square
    expect(rect.rectangle_type).to eq("You have a Square")
  end

  it "identifies an oblong rectangle" do
    rect = build_oblong
    expect(rect.rectangle_type).to eq("You have an Oblong Rectangle")
  end

  it "returns nil for invalid dimensions" do
    fake_input = StringIO.new("0\n3\n")
    rect = Rectangle.new(input: fake_input)
    expect(rect.rectangle_type).to be_nil
  end
end
