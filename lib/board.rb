require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize(placement_validator)
    @cells = create_board
    @placement_validator = placement_validator
  end

  def valid_coordinate?(coordinate)
    @cells.include? coordinate
  end

  def place(ship, coordinates)
    cells_to_use = cells_from_coordinates(coordinates)

    cells_to_use.each do |cell|
      cell.place_ship(ship)
    end
  end

  def cells_occupied?(proposed_cells)
    proposed_cells.all? do |cell|
      cell.empty?
    end
  end

  private

  def create_board
    cells = Hash.new
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        coordinate = "#{letter}#{number}"
        cells[coordinate] = Cell.new(coordinate)
      end
    end

    cells
  end

  def cells_from_coordinates(coordinates)
    # Coords is an array of "A1" and the like
    # Need to return an array of actual Cell objects
    cells_subset = []
    coordinates.each do |coordinate|
      cells_subset << @cells[coordinate]
    end

    cells_subset
  end

end

