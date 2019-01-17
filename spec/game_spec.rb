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

describe "#Game.check_human_move" do
  context "when input in correct range" do
    it "returns input" do
      game = Game.new
      expect(game.check_human_move('4')).to eql('4')
    end
  end
  context "when input over range" do
    it "returns correct error" do
      game = Game.new
      expect(game.check_human_move('8')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when input over range" do
    it "returns correct error" do
      game = Game.new
      expect(game.check_human_move('0')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when input not integer" do
    it "returns correct error" do
      game = Game.new
      expect(game.check_human_move('z')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when no character input" do
    it "returns correct error" do
      game = Game.new
      expect(game.check_human_move('')).to eql('error! input must be integer (from 1, to 7)')
    end
  end
  context "when more than 1 character input" do
    it "returns correct error" do
      game = Game.new
      expect(game.check_human_move('11')).to eql('error! input must be integer (from 1, to 7)')
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
      expect(game.check_human_move('1')).to eql('error! that column is already full')
    end
  end
  context "when input refers to an almost full grid column" do
    it "returns input" do
      game = Game.new
      game.grid = object_double(
        Grid.new, :posn => [["x", "o", "x", "o", "x", "o"],
                            ["-", "x", "o", "x", "o", "x"], # column 2
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"],
                            ["-", "-", "-", "-", "-", "-"]])
      expect(game.check_human_move('2')).to eql('2')
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
      # use srand to ensure first call to rand(7) == 0, which should be rejected
      # as it would refer to column '1', which is full, and thus new values
      # should be generated until a value that refers to a column with free cells
      # is found and returned.
      srand(48893)
      expect(game.create_computer_move).not_to eql(1)
    end
  end
end
