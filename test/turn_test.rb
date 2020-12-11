
require 'minitest/autorun'
require 'minitest/pride'
require './lib/placement_validator'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'

class TurnTest < Minitest::Test

  def setup
    validator = PlacementValidator.new
    @player = Board.new(validator)
    @cpu = Board.new(validator)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_is
    assert_instance_of Turn, @turn
  end

end