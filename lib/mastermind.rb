require "pry"
require_relative "ai.rb"
require_relative "generator.rb"
require_relative "game_code.rb"
require_relative "evaluate.rb"
require_relative "computer_guess.rb"

class MasterMind
  attr_reader :turns, :win, :game_code,
              :computer, :evaluator,
              :generator, :ai, :still_viable

  def initialize
    @turns = 0
    @win = false
    @still_viable = []
    @game_code = GameCode.new
    @computer = ComputerGuess.new
    @evaluator = Evaluate.new
    @generator = Generator.new
    @ai = AI.new
    generator.generate_possible_codes
  end

  def play
    possible_guesses = generator.possible_guesses
    this_games_code = game_code.get_game_code(possible_guesses)
    puts "\n"
    print possible_guesses.size
    while turns < 10 && win == false
      if still_viable.size > 0
        computer.get_educated_guess(@still_viable)
      else
        computer.get_computer_guess
      end
      
      this_guess = computer.computer_guess
      previous_guesses = computer.previous_guesses
      possible_guesses = computer.possible_computer_guesses
      win?(this_games_code, this_guess)
      puts "\n"
      puts "Turn #{turns + 1}"
      puts "\n"
      print this_games_code
      puts "\n"
      print this_guess
      evaluator.evaluate_for_black_pegs(this_games_code, this_guess)
      previous_black = evaluator.previous_black

      evaluator.evaluate_for_white_pegs(this_games_code, this_guess)
      previous_white = evaluator.previous_white

      ai.eliminate(previous_guesses, possible_guesses, previous_black, previous_white)
      @still_viable = ai.still_viable_guesses
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

  def win?(game_code, computer_guess)
    if game_code == computer_guess
      @win = true
    end
  end 
end

game = MasterMind.new
game.play
