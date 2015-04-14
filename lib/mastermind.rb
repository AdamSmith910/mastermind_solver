require "pry"
require_relative "generator.rb"

class MasterMind
  attr_reader :code, :guess, 
              :white_pegs, :turns, :win,
              :black_pegs, :code_count_hash,
              :guess_count_hash, :possible_guesses,
              :guess, :last_guess, :last_black,
              :last_white, :still_viable_guesses,
              :test_code

  def initialize
    @colors = ["red", "blue", "green", "yellow", "orange", "purple"]
    @turns = 0
    @white_pegs = 0
    @win = false
    @guess = []
    @code = []
    @possible_guesses = Generator.new.generate_possible_codes
    @last_guess = []
    @last_black = []
    @last_white = []
    @still_viable_guesses = []
    @test_code = []
  end

  def get_code
    @code = possible_guesses.sample
  end

  def get_guess
    @guess = possible_guesses.sample
    @last_guess << @guess
    @possible_guesses.delete(@guess)
  end

  def play
    get_code
    puts "\n"
    print possible_guesses.size
    while turns < 1297 && win == false
      get_guess
      puts "\n"
      puts "Turn #{turns + 1}"
      puts "\n"
      print code
      puts "\n"
      print guess
      evaluate_for_black_pegs
      evaluate_for_white_pegs
      eliminate
      @turns += 1
    end
    game_over
  end

  def evaluate_for_black_pegs
    win?
    @black_pegs = 0
    i = 0
    while i < 4
      if code[i] == guess[i]
        @black_pegs += 1
      end
      i += 1
    end
  end

  def evaluate_for_white_pegs
    @white_pegs = 0
    code_white = 0
    guess_white = 0

    matching = code & guess
    code_count_hash = Hash.new(0)
    guess_count_hash = Hash.new(0)

    matching.each do |match|
      code.each do |code_el|
        if match == code_el
          code_white += 1
        end
      end

      guess.each do |guess_el|
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
    @last_black << black_pegs
    @last_white << white_pegs

    print "\n"
    print matching
    print "\n"
    print black_pegs
    print "\n"
    print white_pegs
  end

  def eliminate
    test_white = 0

    @test_code = last_guess.last
    test_black = last_black.last
    test_white = last_white.last

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

  def win?
    if code == guess
      @win = true
    end
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
