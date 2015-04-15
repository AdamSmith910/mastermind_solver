require "pry"

require_relative "generator.rb"

class GameCode
  attr_reader :game_code

  def initialize
    @game_code = Generator.new.generate_possible_codes.sample
  end

  def get_game_code
    @game_code
  end
end