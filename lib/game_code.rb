require "pry"

require_relative "generator.rb"

class GameCode
  attr_reader :game_code, :colors

  def initialize
    @colors = ["blue", "green", "orange", "purple", "red", "yellow"] 
  end

  def get_game_code
    @game_code = ""
    print "\n"
    print "Enter a code of four of the following colors: ['blue', 'green', 'orange', 'purple', 'red', 'yellow']
          in the following format: green purple yellow blue.  Duplicates are allowed!"
    print "\n"

    @game_code = gets.strip.downcase
    @game_code = game_code.split(" ")
    if game_code.size != 4
      get_game_code
    end

    game_code.each do |element|
      if !colors.include?(element)
        get_game_code
      end
    end

    game_code
  end
end