require_relative "../Scrabble_module"

class Scrabble::Board

  attr_reader :board

  def initialize
    @board = [[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
              [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]]
  end

  def can_fit_on_board?(word, coordinates, is_horizontal)
    if is_horizontal
      available_spaces = 15 - coordinates[1]
      if available_spaces >= word.length
        return true
      else
        return false
      end
    else # is vertical
      available_spaces = 15 - coordinates[0]
      if available_spaces >= word.length
        return true
      else
        return false
      end
    end
  end

  # def touches_other_letters?(word, coordinates, is_horizontal)
  #
  # end
  #
  #
  # def can_put_word_on_board?(word, coordinates, is_horizontal)  # true = horizontal false = vertical
  #   if can_fit_on_board? == true
  #   end
  #
  # end

  def draw_board

    @board.each do |row|
      print row.to_s + "\n"
    end

  end

  def play_word_on_board(word, coordinates, is_horizontal)

    word.upcase!

    if can_fit_on_board?(word, coordinates, is_horizontal) == true #these will change if we move forward!
        @board[coordinates[0]][coordinates[1]]= word[0]
        row = coordinates[0]
        column = coordinates[1]

        if is_horizontal == true
          word.each_char do |letter|
            @board[row][column] = letter
            column += 1
          end
        else
          word.each_char do |letter|
            @board[row][column] = letter
            row += 1
          end
        end

        # draw_board
        return true

    else
      return false
    end
  end

end

board = Scrabble::Board.new
board.play_word_on_board("dog", [0,0], true)
