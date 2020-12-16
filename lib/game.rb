require './lib/placement_validator'
require './lib/board'
require './lib/turn'

class Game
  def initialize(player_board,cpu_board,turn)
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @cpu_submarine = Ship.new('Submarine', 2)

    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)

    @player_board = player_board
    @cpu_board = cpu_board
    @turn = turn
  end

  def start
    if continue?
      puts @player_board.render(true)

      get_player_placement(@player_cruiser)
      get_player_placement(@player_submarine)
      valid_cpu_cruiser_placement
      valid_cpu_sub_placement
      @turn.play until game_over?

      if cpu_win?
        puts 'You lost!'
      elsif player_win?
        puts 'You won!'
      end

      new_game
      start
    else
      puts "Goodbye!"
    end
  end

  def new_game
    @cpu_cruiser = Ship.new('Cruiser', 3)
    @cpu_submarine = Ship.new('Submarine', 2)

    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)

    @player_board.clear_board
    @cpu_board.clear_board
  end

  def continue?
    puts "Welcome to Battleship!\n"
    puts "Enter P to play. Enter Q to quit.\n"
    input = player_in
    case input[0]
    when "P"
      true
    when "Q"
      false
    else
      puts "Invalid input!"
      continue?
    end
  end

  def game_over?
    cpu_win? || player_win?
  end

  def cpu_win?
    @player_board.has_lost?
  end

  def player_win?
    @cpu_board.has_lost?
  end

  def player_in
    gets.chomp.to_s.upcase.split(' ')
  end

  def get_player_placement(ship)
    puts "Enter #{ship.length} spaces for your #{ship.name}"
    loop do
      coord_input = player_in
      message = @player_board.place(ship, coord_input)
      if message == ''
        break
      else
        puts "Thats an incorrect choice\n"
      end

    end
  end

  def valid_cpu_cruiser_placement
    coordinate_check = ["#{@turn.cpu_random_coordinate}" ,"#{@turn.cpu_random_coordinate}","#{@turn.cpu_random_coordinate}" ]
    until @cpu_board.cpu_place(@cpu_cruiser, coordinate_check)
      coordinate_check = ["#{@turn.cpu_random_coordinate}" ,"#{@turn.cpu_random_coordinate}","#{@turn.cpu_random_coordinate}" ]
    end
  end

  def valid_cpu_sub_placement
    coordinate_check = ["#{@turn.cpu_random_coordinate}" ,"#{@turn.cpu_random_coordinate}"]
    until @cpu_board.cpu_place(@cpu_submarine, coordinate_check)
      coordinate_check = ["#{@turn.cpu_random_coordinate}" ,"#{@turn.cpu_random_coordinate}"]
    end
  end

end
