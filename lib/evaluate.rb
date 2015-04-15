require "pry"
require_relative "game_code.rb"
require_relative "computer_guess.rb"

class Evaluate
  attr_reader :black_pegs, :white_pegs, :previous_black,
              :previous_white

  def initialize
    @black_pegs = 0
    @white_pegs = 0
    @previous_black = []
    @previous_white = []
  end

  def evaluate_for_black_pegs(game_code, computer_guess)
    @black_pegs = 0
    i = 0
    while i < 4
      if game_code[i] == computer_guess[i]
        @black_pegs += 1
      end
      i += 1
    end
    @previous_black << black_pegs
  end

  def evaluate_for_white_pegs(game_code, computer_guess)
    @white_pegs = 0
    code_white = 0
    guess_white = 0

    matching = game_code & computer_guess

    matching.each do |match|
      game_code.each do |code_el|
        if match == code_el
          code_white += 1
        end
      end

      computer_guess.each do |guess_el|
        if match == guess_el
          guess_white += 1
        end
      end
    end

    if code_white > guess_white
      @white_pegs += guess_white
    else
      @white_pegs += code_white
    end

    @white_pegs = white_pegs - black_pegs

    if white_pegs > 2
      @white_pegs = white_pegs - 1
    end
    
    @previous_white << white_pegs

    print "\n"
    print matching
    print "\n"
    print black_pegs
    print "\n"
    print white_pegs
  end
end