require './lib/shape'

# Simple runner for interactive shape classification
def run_shape_classifier
  shape = Shape.new
  result = shape.find_shape
  if result.is_a?(Array)
    result.each { |line| puts line }
  else
    puts result
  end
end

if __FILE__ == $0
  run_shape_classifier
end
