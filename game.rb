class Game
  attr_accessor :grid

  def initialize
    @moves = 0
    @grid = Grid.new
  end

  def start_output
    system "clear"
    print "New Game: human ('o') vs. computer ('x')\n\n"
    @grid.print_posn
  end

  def play
    start_output
    play_round
  end

  def play_round
    print "\nyour move, choose column (1 - 7):"
    input = check_human_move(gets.chomp)

    while input.include?('error') do
      puts input
      print "try again:"
      input = check_human_move(gets.chomp)
    end

    p input
  end

  def check_human_move(input)
    if input.length == 1 && input.to_s =~ /[1-7]/
      if @grid.posn[input.to_i - 1][0] != '-'
        return 'error! that column is already full'
      else
        return input
      end
    else
      return 'error! input must be integer (from 1, to 7)'
    end
  end
end

class Grid
  attr_accessor :posn

  def initialize
    @posn = empty_posn
  end

  def empty_posn
    empty_posn = []
    7.times do
      empty_posn << ['-', '-', '-', '-', '-', '-']
    end
    empty_posn
  end

  def print_posn
    6.times do |i|
      print '     '
      @posn.each {|column| print column[i] + ' '}
      print "\n"
    end
    puts "     1 2 3 4 5 6 7"
  end
end

if __FILE__ == $0
  grid = Grid.new
  grid.add_to_column(2)
  grid.print_posn
  #game = Game.new
  #game.play
end
