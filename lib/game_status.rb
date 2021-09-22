# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  index = -1
  while( index == -1 )
      index = input_to_index( gets.strip )
      if( index != -1 && valid_move?(board, index) )
          move(board, index, current_player(board))
      end
  end
end

def turn_count(board)
  count = 0
  for i in 0...9
      if(position_taken?(board, i) == true)
          count += 1
      end
  end
  return count
end

def won?(board)
  for el in WIN_COMBINATIONS
      if( board[ el[0] ] == 'X' && board[ el[1] ] == 'X' && board[ el[2] ] == 'X' ||
          board[ el[0] ] == 'O' && board[ el[1] ] == 'O' && board[ el[2] ] == 'O' )
          return el
      end
  end
  return false
end

def full?(board)
  return turn_count(board) == 9
end

def over?(board)
  if( full?(board) )
      return true
  elsif( won?(board) )
      return true
  end
  return false
end

def winner(board)
  for el in WIN_COMBINATIONS
      if( board[ el[0] ] == 'X' && board[ el[1] ] == 'X' && board[ el[2] ] == 'X' )
          return 'X'
      elsif( board[ el[0] ] == 'O' && board[ el[1] ] == 'O' && board[ el[2] ] == 'O' )
          return 'O'
      end
  end
  return nil
end

def draw?(board)
  if( won?(board) )
      return false
  elsif( !full?(board) )
      return false
  end
  return true
end

def current_player(board)
  if( turn_count(board) % 2 == 0 )
      return 'X'
  else
      return 'O'     
  end
end

def play(board)
  for el in 0..9
      if( won?(board) )
          break
      end
      if( !full?(board) )
          turn(board)
      end
      
      over?(board)
      draw?(board)
  end
  if( won?(board) )
      puts("Congratulations #{winner(board)}!")
  else
      puts("Cat's Game!")
  end
end