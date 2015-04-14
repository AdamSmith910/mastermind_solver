class Generator
  attr_reader :colors, :possible_codes, :possible_guesses

  def initialize
    @colors = ["red", "blue", "green", "yellow", "orange", "purple"]
    @possible_guesses = []
    @possible_codes = []
  end

  def generate_possible_codes
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
end