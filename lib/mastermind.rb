require "pry"
require_relative "ai.rb"
require_relative "generator.rb"
require_relative "game_code.rb"
require_relative "evaluate.rb"
require_relative "computer_guess.rb"

class MasterMind
  attr_reader :turns, :win, :game_code,
              :computer_guess, :evaluator,
              :generator

  def initialize
    @turns = 0
    @win = false
    @game_code = GameCode.new
    @computer_guess = ComputerGuess.new
    @evaluator = Evaluate.new
    @generator = Generator.new
  end

  def play
    generator.generate_possible_codes
    game_code.get_game_code
    puts "\n"
    print generator.possible_guesses.size
    while turns < 1297 && win == false
      computer_guess.get_computer_guess
      puts "\n"
      puts "Turn #{turns + 1}"
      puts "\n"
      print game_code.game_code
      puts "\n"
      print computer_guess.computer_guess
      evaluator.evaluate_for_black_pegs
      evaluator.evaluate_for_white_pegs
      @turns += 1
    end
    game_over
  end

  def game_over
    if @win == false
      print "\n"
      print "You lose!"
    else
      print "\n"
      print "You win!"
    end
  end  
end

game = MasterMind.new
game.play
