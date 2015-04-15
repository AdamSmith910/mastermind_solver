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

  def get_computer_guess
    @possible_guesses = generator.possible_guesses
    @computer_guess = generator.possible_guesses.sample
    @previous_guesses << computer_guess
    @possible_guesses.delete(computer_guess)
  end
end