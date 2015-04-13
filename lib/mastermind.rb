require "pry"

class MasterMind
  attr_reader :colors, :code, :guess, 
              :white_pegs, :turns, :win,
              :black_pegs, :possible_codes,
              :possible_guesses, :code_count_hash,
              :guess_count_hash

  def initialize
    @colors = ["red", "blue", "green", "yellow", "orange", "purple"]
    @turns = 0
    @white_pegs = 0
    @win = false
    generate_possible_codes
    @guess = []
    @code = []
  end

  def generate_possible_codes
    @possible_codes = []
    @possible_guesses = []

    initial_combos
    color_combo = colors.combination(2).to_a
    color_combo.each do |element|
      @possible_codes << element
    end
    color_combo.each do |element|
      @possible_codes << element.reverse
    end

    initial_guesses
    guess_combo = possible_codes.combination(2).to_a
    guess_combo.each do |element|
      @possible_guesses << element.flatten
    end
    guess_combo.each do |element|
      @possible_guesses << element.reverse.flatten
    end
    @possible_guesses = possible_guesses.uniq
  end

  def initial_combos
    @possible_codes << ["red", "red"]
    @possible_codes << ["blue", "blue"]
    @possible_codes << ["green", "green"]
    @possible_codes << ["yellow", "yellow"]
    @possible_codes << ["orange", "orange"]
    @possible_codes << ["purple", "purple"]
  end

  def initial_guesses
    @possible_guesses << ["red", "red", "red", "red"]
    @possible_guesses << ["blue", "blue", "blue", "blue"]
    @possible_guesses << ["green", "green", "green", "green"]
    @possible_guesses << ["yellow", "yellow", "yellow", "yellow"]
    @possible_guesses << ["orange", "orange", "orange", "orange"]
    @possible_guesses << ["purple", "purple", "purple", "purple"]

    color_pairs = [["red", "red"], ["blue", "blue"], ["green", "green"],
                   ["yellow", "yellow"], ["orange", "orange"],
                   ["purple", "purple"]]
    duplicate_pairs = color_pairs.combination(2).to_a
    duplicate_pairs.each do |element|
      @possible_guesses << element.flatten
    end
    duplicate_pairs.each do |element|
      @possible_guesses << element.reverse!.flatten
    end

    @possible_guesses << ["red", "orange", "red", "orange"]
    @possible_guesses << ["red", "blue", "red", "blue"]
    @possible_guesses << ["red", "green", "red", "green"]
    @possible_guesses << ["red", "yellow", "red", "yellow"]
    @possible_guesses << ["red", "purple", "red", "purple"]

    @possible_guesses << ["blue", "red", "blue", "red"]
    @possible_guesses << ["blue", "orange", "blue", "orange"]
    @possible_guesses << ["blue", "green", "blue", "green"]
    @possible_guesses << ["blue", "yellow", "blue", "yellow"]
    @possible_guesses << ["blue", "purple", "blue", "purple"]

    @possible_guesses << ["green", "red", "green", "red"]
    @possible_guesses << ["green", "orange", "green", "orange"]
    @possible_guesses << ["green", "yellow", "green", "yellow"]
    @possible_guesses << ["green", "blue", "green", "blue"]
    @possible_guesses << ["green", "purple", "green", "purple"]

    @possible_guesses << ["orange", "red", "orange", "red"]
    @possible_guesses << ["orange", "blue", "orange", "blue"]
    @possible_guesses << ["orange", "purple", "orange", "purple"]
    @possible_guesses << ["orange", "green", "orange", "green"]
    @possible_guesses << ["orange", "yellow", "orange", "yellow"]

    @possible_guesses << ["yellow", "red", "yellow", "red"]
    @possible_guesses << ["yellow", "blue", "yellow", "blue"]
    @possible_guesses << ["yellow", "purple", "yellow", "purple"]
    @possible_guesses << ["yellow", "green", "yellow", "green"]
    @possible_guesses << ["yellow", "orange", "yellow", "orange"]

    @possible_guesses << ["purple", "red", "purple", "red"]
    @possible_guesses << ["purple", "blue", "purple", "blue"]
    @possible_guesses << ["purple", "green", "purple", "green"]
    @possible_guesses << ["purple", "orange", "purple", "orange"]
    @possible_guesses << ["purple", "yellow", "purple", "yellow"]
  end

  def get_code
    @code = (1..4).map { colors.sample }
  end

  def get_guess
    @guess = possible_guesses.sample
  end

  def play
    get_code
    puts "\n"
    print possible_guesses.size
    while turns < 10 || win == true
      get_guess
      puts "\n"
      puts "Turn #{turns + 1}"
      puts "\n"
      print code
      puts "\n"
      print guess
      evaluate_for_black_pegs
      evaluate_for_white_pegs
      @turns += 1
    end
    lose
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

    matching = code & guess
    code_count_hash = Hash.new(0)
    guess_count_hash = Hash.new(0)

    matching.each do |match|
      code.each do |element|
        if match == element
          code_count_hash[element] += 1
        end
      end
    end
    code_values = code_count_hash.values

    matching.each do |match|
      guess.each do |element|
        if match == element
          guess_count_hash[element] += 1
        end
      end
    end
    guess_values = guess_count_hash.values

    guess_values.each do |guess_val|
      code_values.each do |code_val|
        if code_val > guess_val
          @white_pegs += guess_val
        else
          @white_pegs += code_val
        end
      end
    end

    @white_pegs = white_pegs - black_pegs

    print "\n"
    print matching
    print "\n"
    print black_pegs
    print "\n"
    print white_pegs
  end

  def win?
    if code == guess
      @win = true
      print "\n"
      print "You win!"
    end
  end

  def lose
    print "\n"
    print "You lose!"
  end

end

game = MasterMind.new
game.play
