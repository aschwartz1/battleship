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

  def test_fired_upon?
    assert_equal false, @cell.fired_upon?
  end

  def test_fire_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  def test_render_empty
    assert_equal ".", @cell.render
  end

  def test_render_miss
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_render_hit
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal "H", @cell.render
  end

  def test_render_sunk
    sunk_cruiser = Ship.new("Cruiser",1)
    @cell.place_ship(sunk_cruiser)
    @cell.fire_upon
    assert_equal "X", @cell.render
  end

end