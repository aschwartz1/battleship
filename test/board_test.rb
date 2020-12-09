# TODO pull things into setup method?

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/cell'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
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
end
