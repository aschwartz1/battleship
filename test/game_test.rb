require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/ship'
require './lib/board'
require './lib/placement_validator'

class GameTest < MiniTest::Test
  def setup
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)

    @placement_validator = PlacementValidator.new
    @player_board = Board.new(@placement_validator)
    @cpu_board = Board.new(@placement_validator)
    @turn = Turn.new(@player_board, @cpu_board)

    @game = Game.new(@player_board, @cpu_board, @turn)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_new_game
    @player_board.place(@cruiser, ["A1","A2","A3"])

    @game.new_game

    # Expecting all cells to be empty after new_game is ran
    assert_equal true, (@player_board.cells.values.all? { |cell| cell.is_a? Cell })
    assert_equal true, @player_board.cells.values.all?(&:empty?)
  end

  def test_knows_when_game_is_over
    cpu_submarine = Ship.new('Submarine', 2)
    player_submarine = Ship.new('Submarine', 2)

    @cpu_board.place(cpu_submarine, ["A1", "A2"])
    @player_board.place(player_submarine, ["A1", "A2"])

    assert_equal false, @game.game_over?

    cpu_submarine.hit
    cpu_submarine.hit

    assert_equal true, @game.game_over?
  end

  def test_cpu_can_win
    cpu_submarine = Ship.new('Submarine', 2)
    player_submarine = Ship.new('Submarine', 2)

    @cpu_board.place(cpu_submarine, ["A1", "A2"])
    @player_board.place(player_submarine, ["A1", "A2"])

    assert_equal false, @game.game_over?

    player_submarine.hit
    player_submarine.hit

    assert_equal true, @game.cpu_win?
  end

  def test_player_can_win
    cpu_submarine = Ship.new('Submarine', 2)
    player_submarine = Ship.new('Submarine', 2)

    @cpu_board.place(cpu_submarine, ["A1", "A2"])
    @player_board.place(player_submarine, ["A1", "A2"])

    assert_equal false, @game.game_over?

    cpu_submarine.hit
    cpu_submarine.hit

    assert_equal true, @game.player_win?
  end

  def test_cpu_can_place_cruiser
    @game.valid_cpu_cruiser_placement

    cells_with_cruisers = @cpu_board.cells.values.select do |cell|
      if !cell.empty?
        cell.ship.name == @cruiser.name
      else
        false
      end
    end

    assert_equal true, cells_with_cruisers.all? { |cell| cell.ship.is_a? Ship }
    assert_equal 3, cells_with_cruisers.length
  end

  def test_cpu_can_place_submarine
    @game.valid_cpu_sub_placement

    cells_with_subs = @cpu_board.cells.values.select do |cell|
      if !cell.empty?
        cell.ship.name == @submarine.name
      else
        false
      end
    end

    assert_equal true, cells_with_subs.all? { |cell| cell.ship.is_a? Ship }
    assert_equal 2, cells_with_subs.length
  end
end

# Requires user input:
#  - start
#  - continue?
#  - player_in
#  - get_player_placement
