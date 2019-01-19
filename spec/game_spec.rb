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

describe "#Grid.rows" do
  context "when called" do
    it "returns lists of indices of rows of position" do
      grid = Grid.new
      expect(grid.rows()).to eql([[[0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5]],
                                  [[0, 4], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4]],
                                  [[0, 3], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3]],
                                  [[0, 2], [1, 2], [2, 2], [3, 2], [4, 2], [5, 2], [6, 2]],
                                  [[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1]],
                                  [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]]])
    end
  end
end

describe "#Grid.columns" do
  context "when called" do
    it "returns lists of indices of columns of position" do
      grid = Grid.new
      expect(grid.columns()).to eql([[[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5]],
                                    [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5]],
                                    [[2, 0], [2, 1], [2, 2], [2, 3], [2, 4], [2, 5]],
                                    [[3, 0], [3, 1], [3, 2], [3, 3], [3, 4], [3, 5]],
                                    [[4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 5]],
                                    [[5, 0], [5, 1], [5, 2], [5, 3], [5, 4], [5, 5]],
                                    [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5]]])
    end
  end
end

describe "#Grid.diagonals" do
  context "when called" do
    it "returns lists of indices of diagonals (with length >= 4) of position" do
      grid = Grid.new
      expect(grid.diagonals()).to eql([[[0, 3], [1, 2], [2, 1], [3, 0]],
                                      [[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]],
                                      [[0, 5], [1, 4], [2, 3], [3, 2], [4, 1], [5, 0]],
                                      [[1, 5], [2, 4], [3, 3], [4, 2], [5, 1], [6, 0]],
                                      [[2, 5], [3, 4], [4, 3], [5, 2], [6, 1]],
                                      [[3, 5], [4, 4], [5, 3], [6, 2]],
                                      [[6, 3], [5, 2], [4, 1], [3, 0]],
                                      [[6, 4], [5, 3], [4, 2], [3, 1], [2, 0]],
                                      [[6, 5], [5, 4], [4, 3], [3, 2], [2, 1], [1, 0]],
                                      [[5, 5], [4, 4], [3, 3], [2, 2], [1, 1], [0, 0]],
                                      [[4, 5], [3, 4], [2, 3], [1, 2], [0, 1]],
                                      [[3, 5], [2, 4], [1, 3], [0, 2]]])
    end
  end
end

describe "#Grid.find_four" do
  context "when passed list referring to grid line containing sequence of 4 identical 'pieces'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', 'o', 'x'],
                ['-', 'o', 'o', 'o', 'o', 'x'],
                ['-', '-', 'o', 'x', 'x', 'x'],
                ['-', '-', 'x', 'o', 'x', 'o'],
                ['-', '-', '-', '-', 'x', 'o'],
                ['-', '-', '-', '-', '-', 'x'],
                ['-', '-', '-', '-', '-', '-']]
    ary = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], 1, 5]
    it "sets @line_of_four to correct winner name" do
      grid.find_four(ary)
      expect(grid.line_of_four).to eql('human')
    end
    it "replaces winning line elements in @posn with uppercase characters" do
      grid.find_four(ary)
      expect(grid.posn).to eql([['-', '-', '-', '-', 'o', 'x'],
                                ['-', 'O', 'O', 'O', 'O', 'x'], # Note 4 * uppercase 'O'
                                ['-', '-', 'o', 'x', 'x', 'x'],
                                ['-', '-', 'x', 'o', 'x', 'o'],
                                ['-', '-', '-', '-', 'x', 'o'],
                                ['-', '-', '-', '-', '-', 'x'],
                                ['-', '-', '-', '-', '-', '-']])
    end
  end
  context "when passed list referring to grid line NOT containing sequence of 4 identical 'pieces'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', 'o', 'x'],
                ['-', 'x', 'o', 'o', 'o', 'x'],
                ['-', '-', 'o', 'x', 'x', 'x'],
                ['-', '-', 'x', 'o', 'x', 'o'],
                ['-', '-', '-', '-', 'x', 'o'],
                ['-', '-', '-', '-', '-', 'x'],
                ['-', '-', '-', '-', '-', '-']]
    ary = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], 1, 5]
    it "does NOT set @line_of_four to a winner name" do
      grid.find_four(ary)
      expect(grid.line_of_four).to eql('')
    end
    it "does NOT change @posn elements" do
      grid.find_four(ary)
      expect(grid.posn).to eql([['-', '-', '-', '-', 'o', 'x'],
                                ['-', 'x', 'o', 'o', 'o', 'x'],
                                ['-', '-', 'o', 'x', 'x', 'x'],
                                ['-', '-', 'x', 'o', 'x', 'o'],
                                ['-', '-', '-', '-', 'x', 'o'],
                                ['-', '-', '-', '-', '-', 'x'],
                                ['-', '-', '-', '-', '-', '-']])
    end
  end
end

describe "#Grid.find_fours" do
  context "when grid COLUMN contains sequence of four identical 'pieces'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', 'o', 'x'],
                ['-', 'o', 'o', 'o', 'o', 'x'],
                ['-', '-', 'o', 'x', 'x', 'x'],
                ['-', '-', 'x', 'o', 'x', 'o'],
                ['-', '-', '-', '-', 'x', 'o'],
                ['-', '-', '-', '-', '-', 'x'],
                ['-', '-', '-', '-', '-', '-']]
    it "changes respective 'piece' labels in @posn to uppercase" do
      grid.find_fours
      expect(grid.posn).to eql([['-', '-', '-', '-', 'o', 'x'],
                                ['-', 'O', 'O', 'O', 'O', 'x'], # Note 4 * uppercase 'O'
                                ['-', '-', 'o', 'x', 'x', 'x'],
                                ['-', '-', 'x', 'o', 'x', 'o'],
                                ['-', '-', '-', '-', 'x', 'o'],
                                ['-', '-', '-', '-', '-', 'x'],
                                ['-', '-', '-', '-', '-', '-']])
    end
  end
  context "when grid ROW contains sequence of four identical 'pieces'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', 'o', 'x'],
                ['-', '-', 'x', 'o', 'o', 'o'],
                ['-', '-', 'o', 'x', 'x', 'o'],
                ['-', '-', 'x', 'o', 'x', 'x'],
                ['-', '-', '-', '-', 'x', 'o'],
                ['-', '-', '-', '-', 'x', 'x'],
                ['-', '-', '-', '-', '-', '-']]
    it "changes respective 'piece' labels in @posn to uppercase" do
      grid.find_fours
      expect(grid.posn).to eql([['-', '-', '-', '-', 'o', 'x'],
                                ['-', '-', 'x', 'o', 'o', 'o'],
                                ['-', '-', 'o', 'x', 'X', 'o'], # Note uppercase 'X'
                                ['-', '-', 'x', 'o', 'X', 'x'], # Note uppercase 'X'
                                ['-', '-', '-', '-', 'X', 'o'], # Note uppercase 'X'
                                ['-', '-', '-', '-', 'X', 'x'], # Note uppercase 'X'
                                ['-', '-', '-', '-', '-', '-']])
    end
  end
  context "when grid DIAGONAL contains sequence of four identical 'pieces'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', 'x', 'o'],
                ['-', '-', 'x', 'o', 'x', 'o'],
                ['-', '-', '-', 'x', 'o', 'x'],
                ['-', '-', 'x', 'o', 'x', 'o'],
                ['-', '-', '-', '-', 'o', 'x'],
                ['-', '-', '-', '-', '-', 'o'],
                ['-', '-', '-', '-', '-', '-']]
    it "changes respective 'piece' labels in @posn to uppercase" do
      grid.find_fours
      expect(grid.posn).to eql([['-', '-', '-', '-', 'x', 'o'],
                                ['-', '-', 'X', 'o', 'x', 'o'], # Note uppercase 'X'
                                ['-', '-', '-', 'X', 'o', 'x'], # Note uppercase 'X'
                                ['-', '-', 'x', 'o', 'X', 'o'], # Note uppercase 'X'
                                ['-', '-', '-', '-', 'o', 'X'], # Note uppercase 'X'
                                ['-', '-', '-', '-', '-', 'o'],
                                ['-', '-', '-', '-', '-', '-']])
    end
  end
  context "when grid contains more than one 'winning line'" do
    grid = Grid.new
    grid.posn = [['-', '-', '-', '-', '-', '-'],
                ['-', '-', '-', '-', 'x', 'x'],
                ['-', '-', '-', '-', 'x', 'x'],
                ['-', '-', 'o', 'x', 'x', 'o'],
                ['-', '-', 'o', 'x', 'o', 'x'],
                ['-', '-', 'o', 'o', 'x', 'x'],
                ['-', '-', 'o', 'o', 'o', 'o']]
    it "changes respective 'piece' labels in @posn to uppercase" do
      grid.find_fours
      # example case where last 'piece' was added to column '7'
      # Note 10 * uppercase 'O'
      expect(grid.posn).to eql([['-', '-', '-', '-', '-', '-'],
                                ['-', '-', '-', '-', 'x', 'x'],
                                ['-', '-', '-', '-', 'x', 'x'],
                                ['-', '-', 'O', 'x', 'x', 'O'],
                                ['-', '-', 'O', 'x', 'O', 'x'],
                                ['-', '-', 'O', 'O', 'x', 'x'],
                                ['-', '-', 'O', 'O', 'O', 'O']]) # column 7
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
