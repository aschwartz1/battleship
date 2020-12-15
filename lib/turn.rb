require './lib/board'
require './lib/ship'

class Turn
  def initialize(player_board, cpu_board)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player_board = player_board
    @cpu_board = cpu_board
  end

  def play
    puts game_state

    player_result = player_shot
    cpu_result = cpu_shot

    puts player_result
    puts cpu_result
  end

  def player_shot
    puts "Which cell would you like to fire on?"
    player_target = gets.chomp.to_s.upcase
    # TODO: Prompt for already fired upon
    until @cpu_board.coordinate_exists_on_board?(player_target) && !@cpu_board.coordinate_already_fired_upon?(player_target)
      puts "Please enter a valid coordinate."
      player_target = gets.chomp.to_s.upcase
    end

    shot_message = @cpu_board.fire_upon(player_target)

    "Your #{shot_message}"
  end

  def cpu_shot
    cpu_target = cpu_random_coordinate

    until @player_board.coordinate_exists_on_board?(cpu_target) && !@player_board.coordinate_already_fired_upon?(cpu_target)
      cpu_target = cpu_random_coordinate
    end

    shot_message = @player_board.fire_upon(cpu_target)

    "My #{shot_message}"
  end

  def cpu_random_coordinate
    #MOVE FROM GAME TO HERE
    (["A", "B", "C", "D"].shuffle)[rand(0..3)] + rand(1..4).to_s
  end

  def game_state
    puts " "
    puts "PLAYER BOARD"
    puts "==================="
    puts @player_board.render(true)
    puts " "
    puts "CPU BOARD"
    puts "==================="
    puts @cpu_board.render
    puts " "
  end
end
