require "pry"

require_relative "generator.rb"

class GameCode
  attr_reader :game_code

  def initialize
    @game_code = []
  end

  def get_game_code(possible_guesses)
    @game_code = possible_guesses.sample
  end
end