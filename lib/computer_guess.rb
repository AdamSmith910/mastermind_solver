require "pry"
require_relative "generator.rb"

class ComputerGuess
  attr_reader :computer_guess, :previous_guesses,
              :possible_guesses, :generator

  def initialize
    @computer_guess = []
    @previous_guesses = []
    @possible_guesses = []
    @generator = Generator.new
    generator.generate_possible_codes
  end

  def find_possible_guesses(still_viable_guesses = nil)
    if still_viable_guesses == nil
      @possible_guesses = generator.possible_guesses
    else
      @possible_guesses = still_viable_guesses
    end
  end

  def get_computer_guess 
    @computer_guess = possible_guesses.sample
    @previous_guesses << computer_guess
    @possible_guesses.delete(computer_guess)
  end
end