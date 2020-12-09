require './lib/ship'

class PlacementValidator
  def is_valid_length?(ship, coords)
    ship.length == coords.count
  end

  def is_consecutive?(coords)
    # Make sure coordinates are 2 chars long
    #
    # Check first char
    # Check second char
  end

  def not_diagonal?(ship, coords)
    # Make sure the return value wants to be true
  end

  def valid_placement?(ship, coords)

  end

  private

  def valid_coordinate_lengths?(coordinates)
    coordinates.any { |coordinate| coordinate.length != 2 }
  end
end
