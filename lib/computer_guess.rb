require "pry"
require_relative "mastermind.rb"

class ComputerGuess
  attr_reader :computer_guess, :previous_guesses,
              :mastermind

  def initialize
    @computer_guess = []
    @previous_guesses = []
    @mastermind = MasterMind.new
  end

  def get_computer_guess
    @computer_guess = mastermind.generator.possible_guesses.sample
    binding.pry
    @previous_guesses << computer_guess
    mastermind.generator.possible_guesses.delete(computer_guess)
  end
end