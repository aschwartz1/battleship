# TODO pull things into setup method?

require 'minitest/autorun'
require 'minitest/pride'
require './lib/placement_validator'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test
  def setup
    placement_validator = PlacementValidator.new
    @board = Board.new(placement_validator)
    @cruiser =  Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_readable_attributes
    cells_hash = @board.cells

    # Cell objects can change, so assert other info about the hash
    assert_equal 16, cells_hash.length
    assert_equal 16, cells_hash.select { |k, v| v.is_a? Cell }.length
  end

  def test_valid_coordinate_true
    coordinate = "A1"

    assert_equal true, @board.valid_coordinate?(coordinate)
  end

  def test_valid_coordinate_false
    coordinate = "X9"

    assert_equal false, @board.valid_coordinate?(coordinate)
  end

  def test_place_ship
    a1 = @board.cells["A1"]
    a2 = @board.cells["A2"]
    a3 = @board.cells["A3"]

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @cruiser, a1.ship
    assert_equal @cruiser, a2.ship
    assert_equal @cruiser, a3.ship
  end

  # TODO IP: remove dependency refactor
  def test_cells_occupied_true
    skip
    # Get a ship placed on known cells
    # Make array that overlaps w/ those cells
    a1 = @board.cells["A1"]
    a2 = @board.cells["A2"]
    a3 = @board.cells["A3"]
    cells = [a1, a2, a3]

    # Do the assert
    assert_equal true, @board.cells_occupied?(cells)
  end

  def test_cells_occupied_false
    skip
    # Get a ship placed on known cells
    @board.place(@cruiser, ["A1", "A2", "A3"])
    # Make array that doesn't overlap w/ those cells
    a1 = @board.cells["A1"]
    a2 = @board.cells["A2"]
    a3 = @board.cells["A3"]
    cells = [a1, a2, a3]

    # Do the assert
    assert_equal false, @board.cells_occupied?(cells)
  end
end
