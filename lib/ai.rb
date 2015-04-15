require "pry"
require_relative "generator.rb"

class AI
  attr_reader :test_code, :still_viable_guesses, :computer_guess

  def initialize
    @test_code = []
    @computer_guess = ComputerGuess.new
  end

  def eliminate(previous_guesses, possible_guesses, previous_black, previous_white)
    @still_viable_guesses = []
    test_white = 0

    @test_code = previous_guesses.last
    test_black = previous_black.last
    test_white = previous_white.last

    possible_guesses.each do |possible_guess|
      if provisional_black(possible_guess) == test_black && provisional_white(possible_guess) == test_white
        @still_viable_guesses << possible_guess
      end
    end

    computer_guess.establish_still_viable(still_viable_guesses)
  end

  def provisional_black(guess_option)
    prov_black = 0
    i = 0
    while i < 4
      if test_code[i] == guess_option[i]
        prov_black += 1
      end
      i += 1
    end
    prov_black
  end

  def provisional_white(guess_option)
    prov_white = 0
    test_code_white = 0
    test_guess_white = 0
    matching = test_code & guess_option

    matching.each do |match_color|
      i = 0
      while i < 4
        if test_code[i] == match_color
          unless test_code[i] == guess_option[i]
            test_code_white += 1
          end
        end
        if guess_option[i] == match_color
          unless guess_option[i] == test_code[i]
            test_guess_white += 1
          end
        end
        i += 1
      end
    end

    if test_code_white > test_guess_white
      prov_white += test_guess_white
    else
      prov_white += test_code_white
    end

    prov_white
  end
end