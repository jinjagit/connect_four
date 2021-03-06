class Game
  attr_accessor :grid

  def initialize # Has no RSpec test
    @moves = 0
    @grid = Grid.new
  end

  def play # Has no RSpec test
    print_game_start
    while @moves < 21 && @grid.line_of_four == '' do
      input, computer_move = play_round
    end
    print_result(input, computer_move)
  end

  def play_round # Has no RSpec test
    input = until_move_input_valid(gets.chomp)
    computer_move = nil
    @grid.add_to_column(input.to_i, 'o')
    @grid.find_fours
    if @grid.line_of_four == ''
      computer_move = create_computer_move
      @grid.add_to_column(computer_move, 'x')
      @grid.find_fours
      print_round(input, computer_move) if @grid.line_of_four == ''
      @moves += 1
    end
     return input, computer_move
  end

  def until_move_input_valid(input) # Has only a test of valid input on 1st input
    until move_input_error?(input) == nil do
      puts move_input_error?(input)
      print "try again; choose column (1 - 7): "
      input = gets.chomp
    end
    input
  end

  def move_input_error?(input)
    if input.length == 1 && input.to_s =~ /[1-7]/
      if @grid.posn[input.to_i - 1][0] != '-'
        return 'error! that column is already full'
      else
        return nil
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

  def print_game_start # Has no RSpec test
    system "clear"
    print "        -- New Game --\n"
    print "human ('o') vs. computer ('x')\n\n"
    @grid.print_posn
    print "\nyour move; choose column (1 - 7): "
  end

  def print_round(input, computer_move) # Has no RSpec test
    system "clear"
    print "  you added 'o' to column #{input}\n"
    print "  cpu added 'x' to column #{computer_move}\n\n"
    @grid.print_posn
    print "\nyour move; choose column (1 - 7): "
  end

  def print_result(input, computer_move) # Has no RSpec test
    system "clear"
    print "  you added 'o' to column #{input}\n"
    if computer_move == nil
      print "\n\n"
    else
      print "  cpu added 'x' to column #{computer_move}\n\n"
    end
    @grid.print_posn
    if @grid.line_of_four == 'cpu'
      print "\n     Game Over: YOU LOSE!\n\n"
    elsif @grid.line_of_four == 'human'
      print "\n     Game Over: YOU WIN!\n\n"
    else
      print "\n      Game Over: DRAW!\n\n"
    end
  end
end

class Grid
  attr_accessor :posn, :line_of_four

  def initialize
    @posn = empty_posn
    @line_of_four = ''
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

  # creates lists of indices of @posn elements in rows of grid
  # (each sub-array of arrays == one such row)
  def rows
    rows = []
    6.times do |i|
      row = []
      7.times {|j| row << [j, 5 - i]}
      rows << row
    end
    rows
  end

  # creates lists of indices of @posn elements in columns of grid
  # (each sub-array of arrays == one such column)
  def columns
    columns = []
    7.times do |i|
      column = []
      6.times {|j| column << [i, j]}
      columns << column
    end
    columns
  end

  # creates lists of indices of @posn elements on grid diagonals of length >= 4
  # (each sub-array of arrays == one such diagonal)
  def diagonals
    diagonals = []
    start_col = 0
    start_row = 3
    i = 0
    while start_row > 0 && start_col < 4 do
      j = 0
      diagonal = []
      while start_row - j >= 0 && start_col + j <= 6 do
        diagonal << [start_col + j, start_row - j]
        j += 1
      end
      diagonals << diagonal
      i += 1
      start_col += 1 if i > 2
      start_row += 1 if start_row < 5
    end
    reverse_diagonals = []
    diagonals.each do |diagonal|
      reverse_diagonal = []
      diagonal.each {|e| reverse_diagonal << [6 - e[0], e[1]]}
      reverse_diagonals << reverse_diagonal
    end
    return diagonals + reverse_diagonals
  end

  # checks if array contains indices of sequence of four 'x' or four 'o'
  # If found, updates the respective @posn elements to uppercase
  # and records respective player name ('cpu' or 'human') in @line_of_four
  def find_four(ary)
    first = 0
    last = 3
    while last + 1 <= ary.length do
      test = []
      4.times do |i|
        test << @posn[ary[first + i][0]][ary[first + i][1]]
      end
      if test.all? {|e| e.downcase == 'x'} || test.all? {|e| e.downcase == 'o'}
        4.times do |i|
          if test[0].downcase == 'x'
            @posn[ary[first + i][0]][ary[first + i][1]]  = 'X'
          else
            @posn[ary[first + i][0]][ary[first + i][1]] = 'O'
          end
        end
        test[0].downcase == 'x' ? @line_of_four = 'cpu' : @line_of_four = 'human'
        break
      end
      first += 1
      last += 1
    end
  end

  def find_fours
    rows.each {|row| find_four(row)}
    columns.each {|column| find_four(column)}
    diagonals.each {|diagonal| find_four(diagonal)}
  end
end

if __FILE__ == $0
  input = 'y'

  while input == 'y' do
    game = nil
    game = Game.new
    game.play
    print "\n     Play again? (y / n) "
    input = gets.chomp

    until input == 'y' || input == 'n' do
      puts "     ERROR! Invalid input"
      print "     Play again? (y / n) "
      input = gets.chomp
    end
  end
end
