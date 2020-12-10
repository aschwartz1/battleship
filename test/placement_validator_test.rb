require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/placement_validator'
require 'pry'

class PlacementValidatorTest < MiniTest::Test
  def setup
    @validator = PlacementValidator.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_is
    assert_instance_of PlacementValidator, @validator
  end

  def test_is_valid_length
    assert_equal true, @validator.is_valid_length?(@submarine,["A1","A2"])
  end

  def test_is_NOT_valid_length
    assert_equal false, @validator.is_valid_length?(@submarine,["A1","A2","A3"])
  end

  def test_is_consecutive
    assert_equal true, @validator.is_consecutive?(["A1", "A2", "A3"])
    assert_equal true, @validator.is_consecutive?(["A1", "A2"])
    assert_equal true, @validator.is_consecutive?(["B1", "C1", "D1"])
    assert_equal true, @validator.is_consecutive?(["B1", "B2","B3"])
    assert_equal true, @validator.is_consecutive?(["D2", "D3","D4"])
  end

  def test_is_not_consecutive
    assert_equal false, @validator.is_consecutive?(["A1", "A3", "A4"])
    assert_equal false, @validator.is_consecutive?(["A1", "A1", "A4"])
    assert_equal false, @validator.is_consecutive?(["A1", "C1"])
    assert_equal false, @validator.is_consecutive?(["A3", "A2", "A1"])
    assert_equal false, @validator.is_consecutive?(["AA1", "A3", "A44"])
  end

  def test_it_is_not_diagonal #which is good
    assert_equal true, @validator.not_diagonal?(["A1", "A3", "A4"])
    assert_equal true, @validator.not_diagonal?(["A1", "C1"])
    assert_equal true, @validator.not_diagonal?(["A3", "A2", "A1"])
    assert_equal true, @validator.not_diagonal?(["A1", "A3", "A4"])
  end

  def test_it_is_not_not_diagonal #which is bad
    assert_equal false, @validator.not_diagonal?(["A1", "B2", "C3"])
    assert_equal false, @validator.not_diagonal?(["B2", "C3", "D4"])
    assert_equal false, @validator.not_diagonal?(["C2", "D3"])
    assert_equal false, @validator.not_diagonal?(["C2C", "DD3"])
  end
end
