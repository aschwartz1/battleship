require './lib/ship'
require './lib/board'

class PlacementValidator
  def validate(ship, coordinates)
    return false if !valid_coordinate_formats?(coordinates)
    return false if !coordinates_match_ship_length?(ship, coordinates)
    return false if !coordinates_are_consecutive?(coordinates)
    true
  end

  def valid_coordinate_formats?(coordinates)
    coordinates.all? { |coordinate| coordinate.length == 2 }
  end

  def coordinates_match_ship_length?(ship, coords)
    ship.length == coords.count
  end

  def coordinates_are_consecutive?(coords)
    coord_chars = coords.map(&:chars)
    numbers = []
    letters = []

    coord_chars.map do |char|
      numbers << char[1].to_i
      letters << char[0].ord
    end

    letters_identical = is_identical?(letters)
    letters_consecutive = is_range_consecutive?(letters)
    numbers_identical = is_identical?(numbers)
    numbers_consecutive = is_range_consecutive?(numbers)

    if letters_identical && numbers_consecutive
      true
    elsif letters_consecutive && numbers_identical
      true
    else
      false
    end
  end

  def is_identical?(range)
    range.uniq.count == 1
  end

  def is_range_consecutive?(range)
    range.each_cons(2).all? { |a , b| b == a + 1 }
  end
end
