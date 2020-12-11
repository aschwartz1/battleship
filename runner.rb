require './lib/placement_validator'
require './lib/board'
require './lib/turn'
require './lib/game'
require 'pry'
validator = PlacementValidator.new
player_board = Board.new(validator)
cpu_board = Board.new(validator)
turn = Turn.new(player_board, cpu_board)
game = Game.new(player_board,cpu_board,turn)

game.start
