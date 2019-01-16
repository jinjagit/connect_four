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
  it "returns correct error if input not integer" do
    game = Game.new
    expect(game.check_human_move('i')).to eql('error')
  end
end
