class Game
  attr_accessor :grid

  def initialize
    @moves = 0
    @grid = Grid.new
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
    column = ['-', '-', '-', '-', '-', '-'] # column: [top, ..., bottom]
    7.times do
      empty_posn << column
    end
    empty_posn
  end

  def print_posn
    6.times do |i|
      @posn.each {|column| print column[i] + ' '}
      print "\n"
    end
    puts "1 2 3 4 5 6 7"
  end
end

if __FILE__ == $0
  #grid = Grid.new
  #grid.print_posn
  game = Game.new
  p game.check_human_move('4')
end
