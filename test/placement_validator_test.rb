require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/placement_validator'

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
end