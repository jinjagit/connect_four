class Grid
  attr_accessor :posn

  def initialize
    @posn = empty_posn
  end

  def empty_posn
    empty_posn = []
    column = ['-', '-', '-', '-', '-', '-']
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
  end
end

grid = Grid.new
p grid.posn
grid.print_posn
