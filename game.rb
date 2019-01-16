class Game
  def initialize
    @moves = 0
    @posn = Grid.new
  end

  def check_human_move(input)
    
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
end
