require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class ShipTest < MiniTest::Test
  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser",3)
  end

  def test_it_is
    assert_instance_of Cell, @cell
  end

  def test_it_has_things
    assert_equal "B4", @cell.coordinate
    refute @cell.ship
  end

  def test_empty?
    assert_equal true, @cell.empty?
  end

  def test_it_can_place_ship
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.empty?
  end
end