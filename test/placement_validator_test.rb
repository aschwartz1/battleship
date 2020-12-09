require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/placement_validator'

class PlacementValidatorTest < MiniTest::Test
  def setup
    @validator = PlacementValidator.new
  end

  def test_it_is
    assert_instance_of PlacementValidator, @validator
  end

end
