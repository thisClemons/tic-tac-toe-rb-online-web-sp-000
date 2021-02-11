WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(spaces)
  puts " #{spaces[0]} | #{spaces[1]} | #{spaces[2]} "
  puts "-----------"
  puts " #{spaces[3]} | #{spaces[4]} | #{spaces[5]} "
  puts "-----------"
  puts " #{spaces[6]} | #{spaces[7]} | #{spaces[8]} "
end


def input_to_index(input)
  input.to_i - 1
end

def move(board, index, team)
  board[index] = team
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index >= 0 && index <= 8 && !position_taken?(board, index)
    return true
  else return false
  end
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" or space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turns = turn_count(board)
  if turns % 2 == 0
    return "X"
  else return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  index = input_to_index(input)

  while !valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets
    index = input_to_index(input)
  end

  move(board, index, current_player(board))
  display_board(board)
end

def won?(board)
  WIN_COMBINATIONS.each do |win|
    p1 = win[0]
    p2 = win[1]
    p3 = win[2]

    ["X", "O"].each do |team|
      if board[p1] == team && board[p2] == team && board[p3] == team
        return win
      end
    end
  end
  return false
end

def full?(board)
  !board.include?(" ") && !board.include?("") && !board.include?(nil)
end

def draw?(board)
  !won?(board) && full?(board) ? true : false
  # return true if !won?(board) && full?(board)
  # return false if !won?(board) && !full?(board)
  # return false if won?(board)
end

def over?(board)
  return true if won?(board) || draw?(board)
  return false
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if(draw?(board))
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end

#play([" ", " ", " ", " ", " ", " ", " ", " ", " "])
