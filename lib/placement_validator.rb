require './lib/ship'

class PlacementValidator
  def is_valid_length?(ship, coords)
    ship.length == coords.count
  end

  def is_consecutive?(ship, coords)

  end

  def not_diagonal?(ship, coords)
    #make sure the return value wants to be true
  end

  def valid_placement?(ship, coords)

  end

end
