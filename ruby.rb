class Player  
  def self.start(player_name)
    puts "#{player_name}, what is your name?"
    @name = gets.chomp
    puts "#{player_name}, what do you want to use? Enter only 1 letter or symbol."
    preferred_symbol = gets.chomp
    if preferred_symbol.length != 1 || preferred_symbol == Player_One.symbol
      until preferred_symbol.length == 1 && preferred_symbol != Player_One.symbol
        if !Player_One.symbol
          puts "Invalid. Try again. Enter only 1 letter or symbol."
          preferred_symbol = gets.chomp
        else
          puts "Invalid. Try again. Enter only 1 letter or symbol. #{Player_One.symbol} has been taken by #{Player_One.name}."
          preferred_symbol = gets.chomp
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

Player_One.start("Player 1")
Player_Two.start("Player 2")
