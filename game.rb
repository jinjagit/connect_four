class Game
  attr_accessor :grid

  def initialize
    @moves = 0
    @grid = Grid.new
    @winner = ''
  end

  def play
    print_game_start
    while @moves < 21 && @winner == '' do
      play_round
      # check_for_win (not written yet)
    end
    print "\n          GAME OVER!\n\n"
  end

  def play_round
    input = until_human_move_valid(gets.chomp)
    @grid.add_to_column(input.to_i, 'o')
    computer_move = create_computer_move
    @grid.add_to_column(computer_move, 'x')
    print_round(input, computer_move)
    @moves += 1
  end

  def valid_human_move?(input)
    check_human_move(input).include?('error') == false
  end

  def until_human_move_valid(input)
    until valid_human_move?(input) do
      puts check_human_move(input)
      print "try again; choose column (1 - 7): "
      input = gets.chomp
    end
    input
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

  def create_computer_move
    computer_move = rand(7)
    until @grid.posn[computer_move][0] == '-'
      computer_move = rand(7)
    end
    computer_move += 1
  end

  def print_game_start
    system "clear"
    print "        -- New Game --\n"
    print "human ('o') vs. computer ('x')\n\n"
    @grid.print_posn
    print "\nyour move; choose column (1 - 7): "
  end

  def print_round(input, computer_move)
    system "clear"
    print "  you added 'o' to column #{input}\n"
    print "  cpu added 'x' to column #{computer_move}\n\n"
    @grid.print_posn
    print "\nyour move; choose column (1 - 7): "
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

  def add_to_column(column, piece)
     6.times do |i|
       if @posn[column - 1][5 - i] == '-'
         @posn[column - 1][5 - i] = piece
         break
       end
     end
  end

  def print_posn
    puts "        1 2 3 4 5 6 7\n"
    6.times do |i|
      print '        '
      @posn.each {|column| print column[i] + ' '}
      print "\n"
    end
  end
end

if __FILE__ == $0
  #grid = Grid.new
  #grid.add_to_column(2)
  #grid.print_posn
  game = Game.new
  game.play
end
