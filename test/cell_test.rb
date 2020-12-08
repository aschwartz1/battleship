require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class ShipTest < MiniTest::Test
  def setup
    @cell = Cell.new("B4")
  end

  def test_it_is
    assert_instance_of Cell, @cell
  end

  def test_it_has_things
    assert_equal "B4", @cell.coordinate
    refute @cell.ship
  end

end