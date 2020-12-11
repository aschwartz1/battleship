require './lib/placement_validator'
require './lib/board'
require './lib/turn'

class Game
  def initialize(player_board,cpu_board,turn)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_board = player_board
    @cpu_board = cpu_board
    @turn = turn
  end

  def start
    puts "Welcome to Battleship!\n"
    puts "Enter the squares for the Cruiser (3 spaces)"
    puts @player_board.render
    player_cruiser_coords = valid_player_cruiser_placement
    cpu_cruiser_coords = valid_cpu_cruiser_placement
    binding.pry
  end

  def valid_player_cruiser_placement
    player_cruiser = gets.chomp.to_s.upcase.split(" ")
    until @player_board.placement_validator.valid_placement?(@cruiser, player_cruiser)
      puts "Thats an incorrect choice\n"
      player_cruiser = gets.chomp.to_s.upcase.split(" ")
    end
    player_cruiser
  end


end