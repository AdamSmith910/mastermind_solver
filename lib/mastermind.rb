require "pry"
require_relative "ai.rb"
require_relative "generator.rb"
require_relative "game_code.rb"
require_relative "evaluate.rb"
require_relative "computer_guess.rb"
require_relative "printer.rb"

class MasterMind
  attr_reader :turns, :win, :game_code,
              :computer, :evaluator,
              :generator, :ai, :still_viable,
              :printer

  def initialize
    @turns = 0
    @win = false
    @still_viable = []
    @game_code = GameCode.new
    @computer = ComputerGuess.new
    @evaluator = Evaluate.new
    @generator = Generator.new
    @ai = AI.new
    @printer = Printer.new
    generator.generate_possible_codes
  end

  def play
    possible_guesses = generator.possible_guesses
    printer.enter_code
    this_games_code = game_code.get_game_code
    while turns < 10 && win == false
      if still_viable.size > 0
        computer.get_educated_guess(@still_viable)
      else
        computer.get_computer_guess
      end
      this_guess = computer.computer_guess
      win?(this_games_code, this_guess)
      previous_guesses = computer.previous_guesses
      possible_guesses = computer.possible_computer_guesses
      printer.this_turn(@turns)
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
      printer.game_over_win
    else
      printer.game_over_lose
    end
    printer.leave
    abort
  end

  def win?(game_code, computer_guess)
    if game_code == computer_guess
      @win = true
    end
  end 
end


