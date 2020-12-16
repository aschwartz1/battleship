
require 'minitest/autorun'
require 'minitest/pride'
require './lib/placement_validator'
require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/turn'
require 'pry'

class TurnTest < Minitest::Test

  def setup
    validator = PlacementValidator.new
    @player = Board.new(validator)
    @cpu = Board.new(validator)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @turn = Turn.new(@player,@cpu)
  end

  def test_it_is
    assert_instance_of Turn, @turn
  end

  def test_cpu_generates_random_coordinates
    3.times do
      coordinate = @turn.cpu_random_coordinate

      assert_equal 2, coordinate.length
      assert_equal true, ('A'..'D').include?(coordinate[0])
      assert_equal true, (1..4).include?(coordinate[1].to_i)
    end
  end

  def test_cpu_chooses_valid_shot
    @turn.cpu_shot
    assert_equal true, @player.cells.values.one? {|cell| cell.fired_upon?}
  end
end

#Things we can't test:
# play
# player_shot
# game_state