require './lib/board'
require './lib/ship'

class Turn
  def initialize(player, cpu)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player = player
    @cpu = cpu
  end

end