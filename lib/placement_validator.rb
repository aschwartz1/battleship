require './lib/ship'

class PlacementValidator
  def is_valid_length?(ship, coords)
    ship.length == coords.count
  end

  def is_consecutive?(coords)
    # Split coords into 2 arrays (for letters & numbers)
    #
    # Is letters arr valid?
    #   - letters are consecutive
    #   - OR letters are all the same
    #
    # Is numbers arr valid?
    #  - numbers are consecutive
    #  - OR numbers are all the same


  end

  # Possibly?
  def is_range_consecutive(range)
    # range is an array of integers
    #
    # Does this even work?
    # is range == range.min.each_cons(range.length)
  end

  def not_diagonal?(ship, coords)
    # Make sure the return value wants to be true
  end

  def valid_placement?(ship, coords)

  end

  private

  def valid_coordinate_lengths?(coordinates)
    # Using "not any" for lack of an "all" enumerable
    !coordinates.any { |coordinate| coordinate.length != 2 }
  end
end
