require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize
    @cells = create_board
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
