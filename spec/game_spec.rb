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

posn_full_col = [["x", "o", "x", "o", "x", "o"],
                ["-", "x", "o", "x", "o", "x"],
                ["-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-"],
                ["-", "-", "-", "-", "-", "-"]]

describe "#Game check_human_move" do
  it "returns input of integer in correct range" do
    game = Game.new
    expect(game.check_human_move('4')).to eql('4')
  end
  it "returns correct error if input out of range" do
    game = Game.new
    expect(game.check_human_move('8')).to eql('error! input must be integer (from 1, to 7)')
  end
  it "returns correct error if input out of range" do
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
  it "returns input of integer if integer refers to almost full grid column" do
    game = Game.new
    game.grid = object_double(Grid.new, :posn => posn_full_col)
    expect(game.check_human_move('2')).to eql('2')
  end
end
