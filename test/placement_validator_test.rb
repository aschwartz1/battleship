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
    assert_equal true, @validator.is_consecutive?(["A1", "A2", "A3"])
    assert_equal true, @validator.is_consecutive?(["A1", "A2"])
    assert_equal true, @validator.is_consecutive?(["B1", "C1", "D1"])
    assert_equal true, @validator.is_consecutive?(["B1", "B2", "B3"])
    assert_equal true, @validator.is_consecutive?(["D2", "D3", "D4"])
  end

  def test_is_not_consecutive
    assert_equal false, @validator.is_consecutive?(["A1", "A3", "A4"])
    assert_equal false, @validator.is_consecutive?(["A1", "A1", "A4"])
    assert_equal false, @validator.is_consecutive?(["A1", "C1"])
    assert_equal false, @validator.is_consecutive?(["A3", "A2", "A1"])
  end

  def test_it_is_diagonal
    assert_equal true, @validator.is_diagonal?(["A1", "B2", "C3"])
    assert_equal true, @validator.is_diagonal?(["B2", "C3", "D4"])
    assert_equal true, @validator.is_diagonal?(["C2", "D3"])
  end

  def test_it_is_not_diagonal
    assert_equal false, @validator.is_diagonal?(["A1", "A3", "A4"])
    assert_equal false, @validator.is_diagonal?(["A1", "C1"])
    assert_equal false, @validator.is_diagonal?(["A3", "A2", "A1"])
  end
end
