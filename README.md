# connect_four
[connect 4](https://en.wikipedia.org/wiki/Connect_Four) in the terminal: RSpec practice

Simon Tharby's solution to [Testing Your Ruby Code](https://www.theodinproject.com/courses/ruby-programming/lessons/testing-your-ruby-code?ref=lnav) (2nd exercise), Odin Project:

## game-play:

The game starts with an empty 'grid' and an invitation to the player to choose which grid column to 'drop' a 'piece' into:

![new_game.png](img/new_game.png)

In the example below, in the first round, a human player has chosen to 'drop' a piece into column 3 and the computer 'chose' to drop a piece into column 6:

![round_1.png](img/round_1.png)


## RSpec tests

The image below shows the output of running <code>rspec</code> (which uses the examples in [game_spec.rb](https://github.com/jinjagit/connect_four/blob/game-win/spec/game_spec.rb)):

![rspec.png](img/rspec.png)
