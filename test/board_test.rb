require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
# require './lib/cell'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_readable_attributes
    board = Board.new
    cells_hash = board.cells

    # Cell objects can change, so assert other info about the hash
    require "pry"; binding.pry
    assert_equal 16, cells_hash.length
    assert_equal 16, cells_hash.select { |k, v| v.is_a? Cell }.length
  end
end
