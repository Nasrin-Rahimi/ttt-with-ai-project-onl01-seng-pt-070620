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
  
  def won?
  end
  
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
    if won? || draw?
      true
    else  
     false
    end
  end
  
  def winner
    if won? == false
     nil
   else 
      @winner
   end
  end
  
   def turn
     index = current_player.move(@board).to_i
     if valid_move?(index)
       move(index-1,current_player.token)
     else
       turn
     end
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
  
end