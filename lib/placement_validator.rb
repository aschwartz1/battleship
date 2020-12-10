require './lib/ship'

class PlacementValidator
  def is_valid_length?(ship, coords)
    ship.length == coords.count
  end

  def is_consecutive?(coords)
    coord_chars = coords.map(&:chars)
    numbers = []
    letters = []

    coord_chars.map do |char|
      numbers << char[1].to_i
      letters << char[0].ord
    end
    
  end


  # Possibly?
  def is_range_consecutive?(range)
    range.each_cons(2).all? {|a , b| b == a+1}
  end

  def not_diagonal?(coords)

  end

  def not_overlapping?(ship, coords)


  end

  def valid_placement?(ship, coords)

  end

  private

  def valid_coordinate_lengths?(coordinates)
    coordinates.all? { |coordinate| coordinate.length == 2 }
  end
end
