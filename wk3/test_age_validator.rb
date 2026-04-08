require 'minitest/autorun'
require_relative 'age_validator'

class TestAgeValidator < Minitest::Test
  def test_valid_equivalence_class
    assert_equal "Valid: eligible age.", validate_age("25")
  end

  def test_boundary_min
    assert_equal "Valid: eligible age.", validate_age("18")
  end

  def test_boundary_max
    assert_equal "Valid: eligible age.", validate_age("65")
  end

  def test_below_min_boundary
    assert_equal "Invalid: age must be at least 18.", validate_age("17")
  end

  def test_above_max_boundary
    assert_equal "Invalid: age must be 65 or younger.", validate_age("66")
  end

  def test_invalid_input
    assert_equal "Invalid input: age must be a number.", validate_age("abc")
  end
end
