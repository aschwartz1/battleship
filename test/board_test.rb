# TODO pull things into setup method?

require 'minitest/autorun'
require 'minitest/pride'
require './lib/placement_validator'
require 'pry'
require './lib/board'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test
  def setup
    placement_validator = PlacementValidator.new
    @board = Board.new(placement_validator)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_readable_attributes
    cells_hash = @board.cells

    # Cell objects can change, so assert other info about the hash
    assert_equal true, (cells_hash.values.all? { |cell| cell.is_a? Cell })
  end

  def test_coordinate_exists
    coordinate = "A1"

    assert_equal true, @board.coordinate_exists_on_board?(coordinate)
  end

  def test_coordinate_exists
    coordinate = "X9"

    assert_equal false, @board.coordinate_exists_on_board?(coordinate)
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

  def test_cells_occupied_true
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal true, @board.cell_occupied?("A1")
    assert_equal true, @board.cell_occupied?("A2")
    assert_equal true, @board.cell_occupied?("A3")
  end

  def test_cells_occupied_false
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.cell_occupied?("A4")
    assert_equal false, @board.cell_occupied?("B1")
  end

  def test_render_empty
    expected =  "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . "

    assert_equal expected, @board.render
  end

  def test_render_override
    @board.place(@cruiser, ["C2", "C3", "C4"])

    expected =  "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . S S S \n" +
                "D . . . . "

    assert_equal expected, @board.render(true)
  end

  def test_fire_upon
    coordinate = "A1"
    cell = @board.cells[coordinate]

    assert_equal false, cell.fired_upon?
    @board.fire_upon(coordinate)
    assert_equal true, cell.fired_upon?
  end

  def test_coordinate_already_fired_upon
    coordinate = "A1"

    assert_equal false, @board.coordinate_already_fired_upon?(coordinate)
    @board.fire_upon(coordinate)
    assert_equal true, @board.coordinate_already_fired_upon?(coordinate)
  end

  def test_cpu_placement
    a1 = @board.cells["A1"]
    a2 = @board.cells["A2"]
    a3 = @board.cells["A3"]

    @board.cpu_place(@cruiser, ["A1", "A2", "A3"])

    assert_equal @cruiser, a1.ship
    assert_equal @cruiser, a2.ship
    assert_equal @cruiser, a3.ship
  end


  def test_has_lost_returns_false
    @board.place(@cruiser, ["A1","A2","A3"])
    @board.place(@submarine,["B1","B2"])

    assert_equal false, @board.has_lost?
  end

  def test_has_lost_returns_true
    cruiser = Ship.new("Cruiser", 0)
    submarine = Ship.new("Submarine", 0)

    @board.place(cruiser, ["A1","A2","A3"])
    @board.place(submarine,["B1","B2"])

    assert_equal true, @board.has_lost?
  end

  def test_it_can_clear_the_board
    @board.place(@cruiser, ["A1","A2","A3"])
    @board.clear_board

    # Cell objects can change, so assert other info about the hash
    assert_equal true, (@board.cells.values.all? { |cell| cell.is_a? Cell })
    assert_equal true, @board.cells.values.all?(&:empty?)
  end

end
