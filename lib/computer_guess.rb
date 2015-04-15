require "pry"
require_relative "generator.rb"

class ComputerGuess
  attr_reader :computer_guess, :previous_guesses,
              :possible_computer_guesses, :generator

  def initialize
    @computer_guess = []
    @previous_guesses = []
    @possible_computer_guesses = []
    @generator = Generator.new
    generator.generate_possible_codes
  end

  def get_educated_guess(still_viable)
    @possible_computer_guesses = still_viable
    @computer_guess = possible_computer_guesses.sample
    @previous_guesses << computer_guess
    @possible_computer_guesses.delete(computer_guess)
  end

  def get_computer_guess
    get_possible
    @computer_guess = possible_computer_guesses.sample
    @previous_guesses << computer_guess 
    @possible_computer_guesses.delete(computer_guess)
  end

  def get_possible
    @possible_computer_guesses = generator.possible_guesses 
  end
end