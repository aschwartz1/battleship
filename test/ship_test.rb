require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < MiniTest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_readable_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  def test_sunk?
    sunk_ship = Ship.new("USS Oops", 0)
    assert_equal true, sunk_ship.sunk?
  end

  def test_hit
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_health_minimum_is_0
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit
    assert_equal 0, @cruiser.health
  end
end
