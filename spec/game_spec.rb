require './game'

describe "#Grid.initialize" do
  context "when initialize Grid instance" do
    it "initializes with 'empty' position" do
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
end

describe "#Grid.print_posn" do
  context "when called" do
    it "prints representation of position" do
      grid = Grid.new
      grid.posn =  [["x", "o", "x", "o", "x", "o"],
                    ["-", "x", "o", "x", "o", "x"],
                    ["-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-"],
                    ["-", "-", "-", "-", "-", "-"]]
      expect { grid.print_posn }.to output(
        <<-MULTILINE_STRING
        1 2 3 4 5 6 7
        x - - - - - -\s
        o x - - - - -\s
        x o - - - - -\s
        o x - - - - -\s
        x o - - - - -\s
        o x - - - - -\s
          MULTILINE_STRING
          ).to_stdout
    end
  end
end

describe "#Grid.add_to_column" do
  context "when passed valid 'column' reference and string" do
    it "adds string to lowest free space in @posn 'column'" do
      grid = Grid.new
      grid.add_to_column(2, 'o')
      grid.add_to_column(2, 'x')
      grid.add_to_column(4, 'o')
      expect(grid.posn).to eql([["-", "-", "-", "-", "-", "-"],
                                ["-", "-", "-", "-", "x", "o"], # column 2
                                ["-", "-", "-", "-", "-", "-"],
                                ["-", "-", "-", "-", "-", "o"], # column 4
                                ["-", "-", "-", "-", "-", "-"],
                                ["-", "-", "-", "-", "-", "-"],
                                ["-", "-", "-", "-", "-", "-"]])
    end
  end
end

describe "#Game.move_input_error?" do
  context "when input in correct range" do
    it "returns nil" do
      game = Game.new
      expect(game.move_input_error?('4')).to eql(nil)
    end
  end
  context "when input over range" do
    it "returns correct error" do
      game = Game.new
      expect(game.move_input_error?('8')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when input over range" do
    it "returns correct error" do
      game = Game.new
      expect(game.move_input_error?('0')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when input not integer" do
    it "returns correct error" do
      game = Game.new
      expect(game.move_input_error?('z')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when no character input" do
    it "returns correct error" do
      game = Game.new
      expect(game.move_input_error?('')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when more than 1 character input" do
    it "returns correct error" do
      game = Game.new
      expect(game.move_input_error?('11')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when input refers to a full grid column" do
    it "returns correct error" do
      game = Game.new
      game.grid = object_double(
        Grid.new, :posn => [["x", "o", "x", "o", "x", "o"],
                            ["-", "x", "o", "x", "o", "x"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"]])
      expect(game.move_input_error?('1')).to eql('error! that column is already full')
    end
  end
  context "when input refers to an almost full grid column" do
    it "returns nil" do
      game = Game.new
      game.grid = object_double(
        Grid.new, :posn => [["x", "o", "x", "o", "x", "o"],
                            ["-", "x", "o", "x", "o", "x"], # column 2
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"]])
      expect(game.move_input_error?('2')).to eql(nil)
    end
  end
end

describe "#Game.create_computer_move" do
  context "when called" do
    it "returns random integer in correct range" do
      game = Game.new
      invalid = false
      100.times do
        test = game.create_computer_move
        invalid = true if test < 1 || test > 7
      end
      expect(invalid).to eql(false)
    end
  end
  context "when called" do
    it "does not return integer == full column label" do
      game = Game.new
      game.grid = object_double(
        Grid.new, :posn => [["x", "o", "x", "o", "x", "o"], # column 1
                            ["-", "x", "o", "x", "o", "x"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"]])
      # use srand to ensure first call to rand(7) == 0, which will be rejected
      # as it refers to column '1' (array index 0) which is 'full', and thus
      # new values wil be generated until a value that refers to a column with
      # free cell(s) is found and returned.
      srand(48893)
      expect(game.create_computer_move).not_to eql(1)
    end
  end
end

# case where input IS valid is trivial, BUT how to test case(s) where human
# input(s) are invalid (resulting in error messages and further input loops) ?
describe "#Game.until_move_input_valid" do
  context "when input is valid" do
    it "returns input" do
      game = Game.new
      expect(game.until_move_input_valid('1')).to eql('1')
    end
  end
end

describe "Grid.rows" do
  context "when passed a grid position" do
    it "returns rows of position" do
      grid = Grid.new
      grid.posn =  [['a6', 'a5', 'a4', 'a3', 'a2', 'a1'],
                    ['b6', 'b5', 'b4', 'b3', 'b2', 'b1'],
                    ['c6', 'c5', 'c4', 'c3', 'c2', 'c1'],
                    ['d6', 'd5', 'd4', 'd3', 'd2', 'd1'],
                    ['e6', 'e5', 'e4', 'e3', 'e2', 'e1'],
                    ['f6', 'f5', 'f4', 'f3', 'f2', 'f1'],
                    ['g6', 'g5', 'g4', 'g3', 'g2', 'g1']]
      expect(grid.rows()).to eql([["a1", "b1", "c1", "d1", "e1", "f1", "g1"],
                                  ["a2", "b2", "c2", "d2", "e2", "f2", "g2"],
                                  ["a3", "b3", "c3", "d3", "e3", "f3", "g3"],
                                  ["a4", "b4", "c4", "d4", "e4", "f4", "g4"],
                                  ["a5", "b5", "c5", "d5", "e5", "f5", "g5"],
                                  ["a6", "b6", "c6", "d6", "e6", "f6", "g6"]])
    end
  end
end

describe "Grid.diagonals" do
  context "when passed a grid position" do
    it "returns diagonals of position, with length >= 4" do
      grid = Grid.new
      grid.posn =  [['a6', 'a5', 'a4', 'a3', 'a2', 'a1'],
                    ['b6', 'b5', 'b4', 'b3', 'b2', 'b1'],
                    ['c6', 'c5', 'c4', 'c3', 'c2', 'c1'],
                    ['d6', 'd5', 'd4', 'd3', 'd2', 'd1'],
                    ['e6', 'e5', 'e4', 'e3', 'e2', 'e1'],
                    ['f6', 'f5', 'f4', 'f3', 'f2', 'f1'],
                    ['g6', 'g5', 'g4', 'g3', 'g2', 'g1']]
      expect(grid.rows()).to eql([["a3", "b4", "c5", "d6"],
                                  ["a2", "b3", "c4", "d5", "e6"],
                                  ["a1", "b2", "c3", "d4", "e5", "f6"],
                                  ["b1", "c2", "d3", "e4", "f5", "g6"],
                                  ["c1", "d2", "e3", "f4", "g5"],
                                  ["d1", "e2", "f3", "g4"],
                                  ["g3", "f4", "e5", "d6"],
                                  ["g2", "f3", "e4", "d5", "c6"],
                                  ["g1", "f2", "e3", "d4", "c5", "b6"],
                                  ["f1", "e2", "d3", "c4", "b5", "a6"],
                                  ["e1", "d2", "c3", "b4", "a5"],
                                  ["d1", "c2", "b3", "a4"]])
    end
  end
end
