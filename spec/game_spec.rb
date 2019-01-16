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

describe "#Game check_human_move" do
  it "returns input of integer in correct range" do
    game = Game.new
    expect(game.check_human_move('1')).to eql('1')
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
end
