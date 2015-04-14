require "pry"

class MasterMind
  attr_reader :colors, :code, :guess, 
              :white_pegs, :turns, :win,
              :black_pegs, :possible_codes,
              :possible_guesses, :code_count_hash,
              :guess_count_hash, :must_have, 
              :still_viable_guesses

  def initialize
    @colors = ["red", "blue", "green", "yellow", "orange", "purple"]
    @turns = 0
    @white_pegs = 0
    @win = false
    generate_possible_codes
    @guess = []
    @code = []
    @previous_guesses = []
    @must_have = []
    @still_viable_guesses = []
  end

  def generate_new_possible_codes
    @possible_codes = []
    @possible_guesses = []

    new_initial_combos
  end

  def new_initial_combos
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
    if turns == 0
      @guess = ["red", "red", "red", "red"]
    elsif turns == 1
      @guess = ["blue", "blue", "blue", "blue"]
    elsif turns == 2
      @guess = ["orange", "orange", "orange", "orange"]
    elsif turns == 3
      @guess = ["green", "green", "green", "green"]
    elsif turns == 4
      @guess = ["purple", "purple", "purple", "purple"]
    elsif turns == 5
      @guess = ["yellow", "yellow", "yellow", "yellow"]
    else
      if white_pegs == 2 && black_pegs == 2
        guess.each do |color|
          @colors << color
        end
        generate_new_possible_codes
        @guess = possible_guesses.sample
      else
        @guess = possible_guesses.sample
      end
    end

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

    guess_score
    must_include

    print "\n"
    print matching
    print "\n"
    print black_pegs
    print "\n"
    print white_pegs
  end

  def guess_score
    score_of_guess = Hash.new(0)
    score_of_guess[@guess] = white_pegs + black_pegs
    eliminate(score_of_guess)
    must_include
  end

  def must_include
    to_remove = []

    if black_pegs > 0
      @must_have << guess.first
    end

    must_have.each do |color|
      possible_guesses.each do |possible_guess|
        unless possible_guess.include?(color)
          to_remove << possible_guess
        end
      end
    end

    to_remove.each do |guess_to_delete|
      @possible_guesses.delete(guess_to_delete)
    end
  end 


  def eliminate(score_of_guess)
    to_remove = []
    colors_to_go = []
    colors_to_go = score_of_guess.keys[0]
    looking_for_zero = score_of_guess.values[0]

    if looking_for_zero == 0
      colors_to_go.each do |color|
        possible_guesses.each do |guess|
          if guess.include?(color)
            to_remove << guess
          end
        end
      end
    end

    to_remove.each do |guess|
      @possible_guesses.delete(guess)
    end
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
