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
                              ["-", "-", "-", "-", "-", "--"]])
  end
end
