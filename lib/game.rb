class Game
  
  attr_accessor :board, :player_1, :player_2
  
   WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]
   
   def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
     @player_1 = player_1
     @player_2 = player_2
     @board = board
     @winner = ""
     @board.display
   end
   
   def current_player
      # turn_count % 2 == 0 ? @player_1 : @player_2
       @board.turn_count.odd? ? @player_2 : @player_1
   end
   
  # def turn_count
  #   @board.cells.count{|token| token == "X" || token == "O"}
  # end
  
  def draw?
    @board.full? && !won? ? true : false
  end
  
   def won?
    WIN_COMBINATIONS.each do |win_combination|
      selected_board = []
      win_combination.each do |index|
        selected_board << @board.cells[index]
      end
     
      if selected_board.uniq.length == 1 && selected_board[0] != " "
        @winner = selected_board[0]
        return win_combination
      end
    end
    return false
  end
  
   def over?
     (won? || draw?) ? true : false
  end
  
  def winner
    if won? == false
     nil
   else 
      @winner
   end
  end
  
  def turn
    puts "Please enter a number 1-9:"
    user_input = current_player.move(@board)
    if @board.valid_move?(user_input)
      @board.update(user_input, current_player)
    else puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end
  
  def valid_move?(index)
    if index.between?(1,9) 
      true
    end
  end
  
   def move(index,token)
    @board.cells[index] = token
  end
  
  def play
    until over? do 
      turn
    end
    if won? != false
      puts "Congratulations #{@winner}!"
    elsif draw? 
      puts "Cat's Game!"
    end
  end
  
  def start
  puts "\nWelcome to Command Line Tic Tac Toe!"
  puts "\nWhat kind of game will you like to play? 
  0 - Computer VS Computer
  1 - You VS Computer
  2 - You VS Your friend"

  player_mode = gets.strip

  if player_mode == "1"
    puts "Do you want to go first? [y/ n]"
    if gets.strip == "y"
      Game.new(Players::Human.new("X"), Players::Computer.new("O"), Board.new).play
    else   Game.new(Players::Computer.new("X"), Players::Human.new("O"), Board.new).play
    end

  elsif player_mode == "0"
    Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new).play

  elsif player_mode == "2"
    Game.new(Players::Human.new("X"), Players::Human.new("O"), Board.new).play
  end
  puts "Would like to play again? [y/ n]"
end

end

