# frozen_string_literal: true

# This class contains details about the players.
class Player
  def self.start(player_name)
    puts "#{player_name}, what is your name?"
    @name = gets.chomp.strip
    puts "#{player_name}, what do you want to use? Enter only 1 letter or symbol."
    preferred_symbol = gets.chomp.strip
    check_symbol(preferred_symbol)
    @symbol = @new_symbol.to_s
  end

  def self.check_symbol(symbol_input)
    until symbol_input.length == 1 && symbol_input != PlayerOne.symbol &&
          symbol_input.match?(/[[:digit:]]/) == false
      if !PlayerOne.symbol
        puts 'Invalid. Try again. Enter only 1 letter or symbol.'
      else
        puts "Invalid. Try again. #{PlayerOne.symbol} has been taken by #{PlayerOne.name}."
      end
      symbol_input = gets.chomp.strip
    end
    @new_symbol = symbol_input
  end

  class << self
    attr_reader :name
  end

  class << self
    attr_reader :symbol
  end
end

class PlayerOne < Player
end

class PlayerTwo < Player
end

# This class contains methods for the tic-tac-toe board.
class Board
  @winner = 'none'

  def self.first_turn
    puts "Who plays first? #{PlayerOne.name}, #{PlayerTwo.name}, or random?"
    @first_turn_answer = gets.chomp.strip
    check_first_turn_validity
    pick_first_player
    puts "#{@first_turn_player.name} plays first."
  end

  def self.show_board
    @current_board = "  1  |  2  |  3  \n ---------------\n  4  |  5  |  6  \n ---------------\n  7  |  8  |  9  "
    puts @current_board
  end

  def self.game
    ask_for_move(@first_turn_player)
    change_board(@first_turn_player)
    which_player_next until @winner == 'yes' || @winner == 'neither'
  end

  def self.ask_for_move(which_player)
    puts "#{which_player.name}, pick a number on the tic-tac-toe board for your turn."
    @move = gets.chomp.strip.to_i
    until (@move.positive? && @move < 10) && @current_board.include?(@move.to_s)
      puts 'Invalid. Pick another number for your turn.'
      @move = gets.chomp.strip.to_i
    end
  end

  def self.change_board(which_player)
    @new_board = @current_board.sub(@move.to_s, which_player.symbol.to_s)
    puts @new_board
    @current_board = @new_board
  end

  def self.check_for_results(which_player_one, which_player_two)
    players = [which_player_one, which_player_two]
    players.each do |player|
      @player = player
      @a = player.symbol
      check_for_winner
      next unless @winner == 'none' && @current_board.match?(/[[:digit:]]/) == false

      puts "It's a draw!"
      @winner = 'neither'
      return "It's a draw!"
    end
  end

  def self.check_for_winner
    @b = @current_board
    if @a == @b[2] && @a == @b[8] && @a == @b[14] || @a == @b[37] && @a == @b[43] && @a == @b[49] ||
       @a == @b[72] && @a == @b[78] && @a == @b[84] || @a == @b[2] && @a == @b[37] && @a == @b[72] ||
       @a == @b[8] && @a == @b[43] && @a == @b[78] || @a == @b[14] && @a == @b[49] && @a == @b[84] ||
       @a == @b[2] && @a == @b[43] && @a == @b[84] || @a == @b[72] && @a == @b[43] && @a == @b[14]
      puts "#{@player.name} is the winner!"
      @winner = 'yes'
      "#{@player.name} is the winner!"
    end
  end

  def self.check_first_turn_validity
    until @first_turn_answer.to_s.downcase == PlayerOne.name.downcase ||
          @first_turn_answer.to_s.downcase == PlayerTwo.name.downcase ||
          @first_turn_answer.to_s.downcase == 'random'
      puts 'Invalid. Try again.'
      @first_turn_answer = gets.chomp.strip
    end
  end

  def self.pick_first_player
    if @first_turn_answer.to_s.downcase == PlayerOne.name.downcase
      @first_turn_player = PlayerOne
    elsif @first_turn_answer.to_s.downcase == PlayerTwo.name.downcase
      @first_turn_player = PlayerTwo
    elsif @first_turn_answer.to_s.downcase == 'random'
      random_number = Random.new.rand(1..10)
      @first_turn_player = random_number.odd? ? PlayerOne : PlayerTwo
    end
  end

  def self.which_player_next
    if @first_turn_player == PlayerOne
      player_turn(PlayerTwo)
      player_turn(PlayerOne) if @winner == 'none'
    elsif @first_turn_player == PlayerTwo
      player_turn(PlayerOne)
      player_turn(PlayerTwo) if @winner == 'none'
    end
  end

  def self.player_turn(other_player)
    Board.ask_for_move(other_player)
    Board.change_board(other_player)
    Board.check_for_results(PlayerOne, PlayerTwo)
  end
end

Board.show_board
PlayerOne.start('Player 1')
PlayerTwo.start('Player 2')
Board.first_turn
Board.game
