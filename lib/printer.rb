require "pry"
require_relative "game_code.rb"

class Printer
  def initialize
    @game_code = GameCode.new
  end

  def welcome
    print "\n"
    print "Welcome to the mastermind solver.  This solver is\n 
          guaranteed to solve any mastermind code you enter\n
          within 6 turns."
  end

  def explanation
    print "\n"
    print "Enter a code of four of the following colors:"
    print "\n"
    print "['blue', 'green', 'orange', 'purple', 'red', 'yellow']"
    print "\n"      
    print "in the following format:" 
    print "\n"
    print "\n"
    print "green purple yellow blue"
    print "\n" 
    print "\n"
    print "Duplicates are allowed!"
  end

  def error
    print "\n"
    print "Invalid command.  Please try again."
  end

  def intro_question
    print "\n"
    print "Would you like to (p)lay, (r)ead the instructions or (q)uit?"
  end

  def enter_code
    print "\n"
    print "Enter your 4 color coded elements"
    print "\n"
    print "\n"
  end

  def game_over_win
    print "\n"
    print "You did the mathematically impossible and stumped the machine"
  end

  def game_over_lose
    print "\n"
    print "Computer solved your code"
  end

  def this_turn(turns)
    print "\n"
    print "Turn #{turns}"
  end

  def leave
    print "\n"
    print "Goodbye!"
    print "\n"
  end
end

printer = Printer.new