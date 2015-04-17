require "pry"
require_relative "printer.rb"
require_relative "mastermind.rb"

class CLI
  attr_reader :command, :printer, :mastermind

  def initialize
    @command = " "
    @printer = Printer.new
    @mastermind = MasterMind.new
  end

  def run
    printer.welcome
    start
  end

  def start
    puts "\n"
    printer.intro_question
    parts = process_input(gets.strip.downcase)
    assigns_instructions(parts)
    execute_command
  end

  def process_input(input)
    input.split
  end

  def assigns_instructions(parts)
    @command = parts[0]
  end

  def execute_command
    while command != 'q'
      case command
      when "play", "p"
        play
      when "read", "r"
        printer.explanation
        start
      else
        print "\n"
        printer.error
        start
      end
    end
    printer.leave
    abort
  end

  def play
    mastermind.play
  end

  def repeat
    printer.intro_question
    input = gets.chomp.downcase
    if input == 'p' || input == "play"
      play
    elsif input == "r" || input == "read"
      printer.explanation
      start
    else
      print "\n"
      printer.error
    end
  end
end

game = CLI.new
game.run
