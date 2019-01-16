require './game'

describe "#Grid initialize" do
  it "initializes Grid instance with 'empty' position" do
    grid = Grid.new
    expect(grid.posn).to eql([["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"]])
  end
end

describe "#Grid add_to_column" do
  it "adds piece to lowest free space in column" do
    grid = Grid.new
    grid.add_to_column(2, 'o')
    grid.add_to_column(2, 'x')
    grid.add_to_column(4, 'o')
    expect(grid.posn).to eql([["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "x", "o"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "o"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"],
                              ["-", "-", "-", "-", "-", "-"]])
  end
end

posn_full_col =  [["x", "o", "x", "o", "x", "o"],
                  ["-", "x", "o", "x", "o", "x"],
                  ["-", "-", "-", "-", "-", "-"],
                  ["-", "-", "-", "-", "-", "-"],
                  ["-", "-", "-", "-", "-", "-"],
                  ["-", "-", "-", "-", "-", "-"],
                  ["-", "-", "-", "-", "-", "-"]]

describe "#Game check_human_move" do
  it "returns input integer in correct range" do
    game = Game.new
    expect(game.check_human_move('4')).to eql('4')
  end
  it "returns correct error if input over range" do
    game = Game.new
    expect(game.check_human_move('8')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if input under range" do
    game = Game.new
    expect(game.check_human_move('0')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if input not integer" do
    game = Game.new
    expect(game.check_human_move('z')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if no character input" do
    game = Game.new
    expect(game.check_human_move('')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if more than 1 character input" do
    game = Game.new
    expect(game.check_human_move('11')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if input refers to full grid column" do
    game = Game.new
    game.grid = object_double(Grid.new, :posn => posn_full_col)
    expect(game.check_human_move('1')).to eql('error! that column is already full')
  end
  it "returns input integer if integer refers to almost full grid column" do
    game = Game.new
    game.grid = object_double(Grid.new, :posn => posn_full_col)
    expect(game.check_human_move('2')).to eql('2')
  end
end

describe "#Game create_computer_move" do
  it "returns random integer in correct range" do
    game = Game.new
    invalid = false
    100.times do
      test = game.create_computer_move
      invalid = true if test < 1 || test > 7
    end
    expect(invalid).to eql(false)
  end
  it "will not return integer == full column label" do
    game = Game.new
    game.grid = object_double(Grid.new, :posn => posn_full_col)
    # use srand to ensure first call to rand(7) == 0, which should be rejected
    # as it would refer to column '1', which is full, and thus new values
    # should be generated until a value that refers to a column with free cells
    # is found and returned.
    srand(48893)
    expect(game.create_computer_move).not_to eql(1)
  end
end
