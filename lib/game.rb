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

  end

  def valid_player_cruiser_placement
    player_cruiser = gets.chomp.to_s.upcase.split(" ")
    until @player_board.placement_validator.valid_placement?(@cruiser, player_cruiser)
      puts "Thats an incorrect choice\n"
      player_cruiser = gets.chomp.to_s.upcase.split(" ")
    end
    player_cruiser
  end

  def cpu_random_coordinate
    (["A", "B", "C", "D"].shuffle)[rand(0..3)] + rand(1..4).to_s
  end

  def valid_cpu_cruiser_placement
    coordinate_check = ["#{cpu_random_coordinate}" ,"#{cpu_random_coordinate}","#{cpu_random_coordinate}" ]
    until @player_board.placement_validator.valid_placement?(@cruiser, coordinate_check)
      coordinate_check = ["#{cpu_random_coordinate}" ,"#{cpu_random_coordinate}","#{cpu_random_coordinate}" ]
    end
    coordinate_check
    #some code here for either shooting in the dark
    # or generating only valid coordinates
  end

end