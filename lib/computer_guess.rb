require "pry"
require_relative "generator.rb"

class ComputerGuess
  attr_reader :computer_guess, :previous_guesses,
              :possible_guesses, :still_viable,
              :generator

  def initialize
    @computer_guess = []
    @previous_guesses = []
    @possible_guesses = []
    @still_viable = nil
    @generator = Generator.new
  end

  def establish_still_viable(still_viable)
    @still_viable = still_viable
  end

  def get_computer_guess
    if still_viable == nil
      generator.generate_possible_codes
      @possible_guesses = generator.possible_guesses
      @possible_guesses.delete(previous_guesses.last)
      @computer_guess = possible_guesses.sample
      @previous_guesses << computer_guess

      computer_guess
    else
      @computer_guess = still_viable.sample
    end
  end
end