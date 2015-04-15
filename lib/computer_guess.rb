require "pry"
require_relative "generator.rb"
require_relative "ai.rb"

class ComputerGuess
  attr_reader :computer_guess, :previous_guesses,
              :ai, :generator

  def initialize
    @computer_guess = []
    @previous_guesses = []
    @ai = AI.new
    @generator = Generator.new
    generator.generate_possible_codes
  end

  def get_computer_guess(possible_guesses = nil)
    if possible_guesses == nil
      possible_guesses = generator.possible_guesses
    else
      possible_guesses = possible_guesses
    end
    @computer_guess = possible_guesses.sample
    @previous_guesses << computer_guess
  end
end