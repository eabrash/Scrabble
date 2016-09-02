require_relative "../Scrabble_module"
require_relative "Scrabble_scoring"

class Scrabble::Board

  attr_reader :board

  SPECIAL_BOARD = [["3W", nil, nil, "2L", nil, nil, nil, "3W", nil, nil, nil, "2L", nil, nil, "3W"],
                   [nil, "2W", nil, nil, nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "2W", nil],
                   [nil, nil, "2W", nil, nil, nil, "2L", nil, "2L", nil, nil, nil, "2W", nil, nil],
                   ["2L", nil, nil, "2W", nil, nil, nil, "2L", nil, nil, nil, "2W", nil, nil, "2L"],
                   [nil, nil, nil, nil, "2W", nil, nil, nil, nil, nil, "2W", nil, nil, nil, nil],
                   [nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "3L", nil],
                   [nil, nil, "2L", nil, nil, nil, "2L", nil, "2L", nil, nil, nil, "2L", nil, nil],
                   ["3W", nil, nil, "2L", nil, nil, nil, "*", nil, nil, nil, "2L", nil, nil, "3W"],
                   [nil, nil, "2L", nil, nil, nil, "2L", nil, "2L", nil, nil, nil, "2L", nil, nil],
                   [nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "3L", nil],
                   [nil, nil, nil, nil, "2W", nil, nil, nil, nil, nil, "2W", nil, nil, nil, nil],
                   ["2L", nil, nil, "2W", nil, nil, nil, "2L", nil, nil, nil, "2W", nil, nil, "2L"],
                   [nil, nil, "2W", nil, nil, nil, "2L", nil, "2L", nil, nil, nil, "2W", nil, nil],
                   [nil, "2W", nil, nil, nil, "3L", nil, nil, nil, "3L", nil, nil, nil, "2W", nil],
                   ["3W", nil, nil, "2L", nil, nil, nil, "3W", nil, nil, nil, "2L", nil, nil, "3W"]]
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

  def incorporate_special_letter(letter, row, column)
       letter.upcase!
       puts "Letter: #{letter}, Row: #{row}, Column: #{column}"
       if SPECIAL_BOARD[row][column] == nil || SPECIAL_BOARD[row][column] == "*" || SPECIAL_BOARD[row][column] == "2W" || SPECIAL_BOARD[row][column] == "3W"
         puts "If not letter-ly special"
         return Scrabble::Scoring.score(letter)
       elsif SPECIAL_BOARD[row][column] == "2L"
          puts "If 2L special"
          return Scrabble::Scoring.score(letter) * 2
       elsif SPECIAL_BOARD[row][column] == "3L"
          puts "If 3L special"
          return Scrabble::Scoring.score(letter) * 3
        else
          puts "WEIRDNESS OCCURRED"
       end
  end

  def incorporate_special_word(word, row, column, is_horizontal, score)

    if is_horizontal == true
      word.each_char do |letter|
        if SPECIAL_BOARD[row][column] == "2W"
          score *= 2
        elsif SPECIAL_BOARD[row][column] == "3W"
          score *= 3
        end
        column += 1
      end
    else
      word.each_char do |letter|
        if SPECIAL_BOARD[row][column] == "2W"
          score *= 2
        elsif SPECIAL_BOARD[row][column] == "3W"
          score *= 3
        end
        row += 1
      end
    end

    return score

  end

  def score_from_special_board(word, coordinates, is_horizontal)

    row = coordinates[0]
    column = coordinates[1]
    score = 0

    if is_horizontal == true
      word.each_char do |letter|
        score += incorporate_special_letter(letter, row, column)
        column += 1
      end
    else
      word.each_char do |letter|
        score += incorporate_special_letter(letter, row, column)
        row += 1
      end
    end

    score = incorporate_special_word(word, coordinates[0], coordinates[1], is_horizontal, score)

    return score

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
puts "Playing CAT at 0,0: " + board.score_from_special_board("cat", [0,0], true).to_s
puts "Playing TOAD at 0,0: " + board.score_from_special_board("toad", [0,0], true).to_s