require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/placement_validator'
require 'pry'

class PlacementValidatorTest < MiniTest::Test
  def setup
    @validator = PlacementValidator.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)

    @board = Board.new(@validator)
  end

  def test_it_is
    assert_instance_of PlacementValidator, @validator
  end

  def test_validate
    assert_equal false, @validator.validate(@cruiser, ["AA2", "A3"]) # Coordinate format
    assert_equal false, @validator.validate(@submarine, ["A1", "A2", "A3"]) # Ship length =/= coordinate length
    assert_equal false, @validator.validate(@cruiser, ["A1", "C1"]) # Not consecutive
    assert_equal false, @validator.validate(@cruiser, ["A1", "A3", "A4"]) # Diagonal
    assert_equal true, @validator.validate(@cruiser, ["A3", "B3", "C3"]) # All good
  end

  def test_coordinates_match_ship_length
    assert_equal true, @validator.coordinates_match_ship_length?(@submarine, ["A1", "A2"])
  end

  def test_rejects_coordinates_not_matching_ship_length
    assert_equal false, @validator.coordinates_match_ship_length?(@submarine, ["A1", "A2", "A3"])
  end

  def test_rejects_weird_coordinates
    assert_equal false, @validator.valid_coordinate_formats?(["AA2", "A3"])
  end

  def test_is_consecutive
    assert_equal true, @validator.coordinates_are_consecutive?(["A1", "A2", "A3"])
    assert_equal true, @validator.coordinates_are_consecutive?(["A1", "A2"])
    assert_equal true, @validator.coordinates_are_consecutive?(["B1", "C1", "D1"])
    assert_equal true, @validator.coordinates_are_consecutive?(["B1", "B2", "B3"])
    assert_equal true, @validator.coordinates_are_consecutive?(["D2", "D3", "D4"])
  end

  def test_is_not_consecutive
    # Random coords (aka, not consecutive)
    assert_equal false, @validator.coordinates_are_consecutive?(["A1", "A3", "A4"])
    assert_equal false, @validator.coordinates_are_consecutive?(["A1", "A1", "A4"])
    assert_equal false, @validator.coordinates_are_consecutive?(["A1", "C1"])
    # All coords are the same
    assert_equal false, @validator.coordinates_are_consecutive?(["A1", "A1", "A1"])
    # Reversed
    assert_equal false, @validator.coordinates_are_consecutive?(["A3", "A2", "A1"])
    # Diagonal
    assert_equal false, @validator.coordinates_are_consecutive?(["A1", "B2", "C3"])
    assert_equal false, @validator.coordinates_are_consecutive?(["C2", "D3"])
  end

  def test_is_identical_true
    assert_equal true, @validator.is_identical?(["A".ord, "A".ord, "A".ord])
  end

  def test_is_identical_false
    assert_equal false, @validator.is_identical?(["A".ord, "B".ord, "C".ord])
  end

  def test_is_range_consecutive_true
    assert_equal true, @validator.is_range_consecutive?(["A".ord, "B".ord, "C".ord])
  end

  def test_is_range_consecutive_false
    assert_equal false, @validator.is_range_consecutive?(["D".ord, "B".ord, "A".ord])
  end
end
