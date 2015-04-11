class MasterMind
  attr_reader :colors, :code, :guess, 
              :white_pegs, :turns, :win,
              :code_el_num, :guess_el_num,
              :black_pegs

  def initialize
    @colors = ["red", "blue", "green", "yellow", "orange"]
    @turns = 0
    @white_pegs = 0
    @win = false
  end

  def get_code
    @code = (1..4).map { colors.sample }
  end

  def get_guess
    @guess = (1..4).map { colors.sample }
  end

  def play
    get_code
    while turns < 11 && win == false
      get_guess
      puts "\n"
      print code
      puts "\n"
      print guess
      evaluate_for_black_pegs
      evaluate_for_white_pegs
      @turns += 1
    end
  end

  def evaluate_for_black_pegs
    @black_pegs = 0
    i = 0
    while i < 4
      if code[i] == guess[i]
        @black_pegs += 1
      end
      i += 1
    end
  end

  def evaluate_for_white_pegs
    win?
    @white_pegs = 0
    matching = code & guess
    @code_el_num = 0
    @guess_el_num = 0

    matching.each do |match_el|
      code.each do |code_el|
        if code_el == match_el
          @code_el_num += 1
        end
      end
    end

    matching.each do |match_el|
      guess.each do |guess_el|
        if guess_el == match_el
          @guess_el_num += 1
        end
      end
    end

    if code_el_num < guess_el_num
      @white_pegs += code_el_num
    else
      @white_pegs += guess_el_num
    end

    @white_pegs = white_pegs - black_pegs

    print "\n"
    print matching
    print "\n"
    print black_pegs
    print "\n"
    print white_pegs
  end

  def win?
    code == guess
  end

end

game = MasterMind.new
game.play
