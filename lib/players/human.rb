 require_relative "../player.rb"
module Players
  
  class Human < Player
    
    def move(board)
      puts "Please enter a number"
      gets.strip
    end
    
  end
  
end