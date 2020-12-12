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
    player_shot
    cpu_shot
    puts "Your shot was whatever"
    puts "my shot was whatever"
  end

  def player_shot
    puts "Which cell would you like to fire on"
    player_target = gets.chomp.to_s.upcase
    until @cpu_board.coordinate_exists_on_board?(player_target) && !@cpu_board.coordinate_already_fired_upon?(player_target)
      puts "Invalid target"
      player_target = gets.chomp.to_s.upcase
    end
    @cpu_board.fire_upon(player_target)
    # @cpu_board.cells[player_target].fire_upon
    # @player_board.blacklist << player_target
  end

  def cpu_shot
    cpu_target = cpu_random_coordinate
    until @player_board.coordinate_exists_on_board?(cpu_target) && !@player_board.coordinate_already_fired_upon?(cpu_target)
      cpu_target = cpu_random_coordinate
    end
    @player_board.fire_upon(cpu_target)
    # @player_board.cells[cpu_target].fire_upon
    # @cpu_board.blacklist << cpu_target
  end

  def cpu_random_coordinate
    #MOVE FROM GAME TO HERE
    (["A", "B", "C", "D"].shuffle)[rand(0..3)] + rand(1..4).to_s
  end

  def game_state
    puts "PLAYER BOARD"
    puts "==================="
    puts @player_board.render(true)
    puts "CPU BOARD"
    puts "==================="
    puts @cpu_board.render
  end

end
