class Player  
  def self.start(player_name)
    puts "#{player_name}, what is your name?"
    @name = gets.chomp.strip
    puts "#{player_name}, what do you want to use? Enter only 1 letter or symbol."
    preferred_symbol = gets.chomp.strip
    if preferred_symbol.length != 1 || preferred_symbol == Player_One.symbol
      until preferred_symbol.length == 1 && preferred_symbol != Player_One.symbol
        if !Player_One.symbol
          puts "Invalid. Try again. Enter only 1 letter or symbol."
          preferred_symbol = gets.chomp.strip
        else
          puts "Invalid. Try again. Enter only 1 letter or symbol. #{Player_One.symbol} has been taken by #{Player_One.name}."
          preferred_symbol = gets.chomp.strip
        end
      end
    end
    @symbol = preferred_symbol
  end

  def self.name()
    return @name
  end

  def self.symbol()
    return @symbol
  end
end

class Player_One < Player
end

class Player_Two < Player
end

class Board
  def self.first_turn
    puts "Who plays first? #{Player_One.name}, #{Player_Two.name}, or random?"
    first_turn_answer = gets.chomp.strip
    until first_turn_answer.downcase == Player_One.name.downcase || 
      first_turn_answer.downcase == Player_Two.name.downcase || 
      first_turn_answer.downcase == "random"
      puts "Invalid. Try again."
      first_turn_answer = gets.chomp.strip
    end
    if first_turn_answer.downcase == Player_One.name.downcase
      @first_turn_player = Player_One.name
    elsif first_turn_answer.downcase == Player_Two.name.downcase
      @first_turn_player = Player_Two.name
    elsif first_turn_answer.downcase == "random"
      random_number = Random.new.rand(1..10)
      if random_number.odd?
        @first_turn_player = Player_One.name
      else
        @first_turn_player = Player_Two.name
      end
    end
    puts "#{@first_turn_player} plays first."
  end

  def self.show_board
    @current_board = "  1  |  2  |  3  \n ---------------\n  4  |  5  |  6  \n ---------------\n  7  |  8  |  9  "
    puts @current_board
  end

  def self.ask_for_move
    puts "#{@first_turn_player}, pick a number on the tic-tac-toe board for your turn."
    @move = gets.chomp.strip.to_i
    until @move > 0 && @move < 10
      puts "Invalid. #{@first_turn_player}, pick a number on the tic-tac-toe board for your turn."
      @move = gets.chomp.strip.to_i
    end
  end

  def self.change_board
    @new_board = @current_board.sub("#{@move.to_s}", "#{Player_One.symbol}")
    puts @new_board
    @current_board = @new_board
  end

  def self.game
    winner = "none"
    Board.ask_for_move
    Board.change_board
    until winner == "yes"
      Board.ask_for_move
      Board.change_board
    end
  end
end

Board.show_board
Player_One.start("Player 1")
Player_Two.start("Player 2")
Board.first_turn
Board.game
