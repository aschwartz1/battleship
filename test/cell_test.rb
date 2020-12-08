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

end