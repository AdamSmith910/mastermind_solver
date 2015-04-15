require "pry"

class AI
  attr_reader :test_code, :still_viable_guesses

  def initialize
    @test_code = ""
    @still_viable_guesses = []
  end

  def eliminate
    test_white = 0

    @test_code = mastermind.previous_guesses.last
    test_black = mastermind.last_black.last
    test_white = mastermind.last_white.last

    possible_guesses.each do |possible_guess|
      if provisional_black(possible_guess) == test_black && provisional_white(possible_guess) == test_white
        @still_viable_guesses << possible_guess
      end
    end

    @possible_guesses = still_viable_guesses
    binding.pry
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
    matching = test_code & guess_option

    matching.each do |match|
      guess_option.each do |guess_el|
        if match == guess_el
          prov_white += 1
        end
      end
    end

    prov_white = prov_white - provisional_black(guess_option)

    if prov_white > 2
      prov_white = prov_white - 1
    end

    prov_white
  end
end