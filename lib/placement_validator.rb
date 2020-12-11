require './lib/ship'
require './lib/board'
class PlacementValidator

  def initialize
    # @board = Board.new
  end

  def validate(ship, coordinates)
    return false if !valid_coordinate_formats?(coordinates)
    return false if !coordinates_match_ship_length?(ship, coordinates)
    return false if !is_consecutive?(coordinates)
    return false if is_diagonal?(coordinates)
    true
  end

  def coordinates_match_ship_length?(ship, coords)
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

    is_identical?(numbers) && is_identical?(letters)
  end

  def is_diagonal?(coords)
    coord_chars = coords.map(&:chars)
    numbers = []
    letters = []

    coord_chars.map do |char|
      numbers << char[1].to_i
      letters << char[0].ord
    end

    letters.uniq.count > 1 && numbers.uniq.count > 1
  end

  def is_identical?(range)
    if range.uniq.count == 1
      true
    else
      is_range_consecutive?(range)
    end
  end

  def is_range_consecutive?(range)
    range.each_cons(2).all? { |a , b| b == a + 1 }
  end

  def valid_coordinate_formats?(coordinates)
    coordinates.all? { |coordinate| coordinate.length == 2 }
  end
end
