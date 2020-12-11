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
    puts @player_board.render
    player_cruiser_coords = get_player_placement(@cruiser)
    player_sub_coords = get_player_placement(@submarine)
    binding.pry
    cpu_cruiser_coords = valid_cpu_cruiser_placement

  end

  def player_in
    gets.chomp.to_s.upcase.split(" ")
  end

  def get_player_placement(ship)
    puts "Enter #{ship.length} spaces for you #{ship.name}"
    loop do
      coord_input = player_in
      message = @player_board.place(ship, coord_input)
      if message == ""
        break
      else
        puts "Thats an incorrect choice\n"
      end

    end
  end

  def cpu_random_coordinate
    (["A", "B", "C", "D"].shuffle)[rand(0..3)] + rand(1..4).to_s
  end

  def valid_cpu_cruiser_placement
    coordinate_check = ["#{cpu_random_coordinate}" ,"#{cpu_random_coordinate}","#{cpu_random_coordinate}" ]
    until @cpu_board.placement_validator.validate(@cruiser, coordinate_check)
      coordinate_check = ["#{cpu_random_coordinate}" ,"#{cpu_random_coordinate}","#{cpu_random_coordinate}" ]
    end
    coordinate_check
    #some code here for either shooting in the dark
    # or generating only valid coordinates
  end

end