require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells,
              :placement_validator,
              :blacklist

  def initialize(placement_validator)
    @cells = create_board
    @placement_validator = placement_validator
    @blacklist = []
  end

  def place(ship, coordinates)
    error_message = ""

    if valid_placement?(ship, coordinates)
      cells_to_use = cells_from_coordinates(coordinates)

      cells_to_use.each do |cell|
        cell.place_ship(ship)
      end
    else
      error_message = "#{ship} couldn't be placed."
    end

    error_message
  end

  def cpu_place(ship,coordinates)

    if valid_placement?(ship, coordinates)
      cells_to_use = cells_from_coordinates(coordinates)

      cells_to_use.each do |cell|
        cell.place_ship(ship)
      end
    else
      false
    end
  end

  def has_lost?
    all_ships = @cells.values.find_all do |cell|
      !cell.empty?
    end

    all_ships.all? do |cell|
      cell.ship.sunk?
    end
  end

  def cell_occupied?(coordinate)
    !cell_from_coordinate(coordinate).empty?
  end

  def render(override=false)
    prev_row_char = ""
    render_string = ""
    pad = " "
    newline = "\n"

    # Statically type out first row
    render_string = "#{pad * 2}1#{pad}2#{pad}3#{pad}4 "

    # Dynamically build rest of rows
    @cells.each do |coord, cell|

      # First part of coordinate determines our row
      curr_row_char = coord[0]
      cell_render = cell.render(override)

      # First time on this row, add row header and padding
      if curr_row_char != prev_row_char
        render_string += "#{newline}#{curr_row_char}#{pad}"
      end

      # All passes through loop, add the cell's render
      render_string += "#{cell_render}#{pad}"

      # Keep track of the row char so we know when it changes
      prev_row_char = curr_row_char
    end

    render_string
  end

  def coordinate_exists_on_board?(coordinate)
    @cells.include? coordinate
  end

  def fire_upon(coordinate)
    shot_message = @cells[coordinate].fire_upon
    add_to_blacklist(coordinate)

    shot_message
  end

  def coordinate_already_fired_upon?(coordinate)
    @blacklist.include? coordinate
  end

  def clear_board
    @cells = create_board
    @blacklist = []
  end

  def add_to_blacklist(coordinate)
    @blacklist << coordinate
  end

  def valid_placement?(ship, coordinates)
    return false if coordinates.any? do |coord|
      !coordinate_exists_on_board?(coord) || cell_occupied?(coord)
    end
    return false if !placement_validator.validate(ship, coordinates)
    true
  end

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

  def cell_from_coordinate(coordinate)
    @cells[coordinate]
  end
end

