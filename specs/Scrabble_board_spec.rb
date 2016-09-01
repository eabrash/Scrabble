require_relative "Spec_helper"
require_relative "../lib/Scrabble_board"

describe "Testing Scrabble board" do

  it "Tell if a short word fits in an open space, horizontally" do
    board = Scrabble::Board.new
    expect(board.can_fit_on_board?("cat", [0,0], true)).must_equal(true)
  end

  it "Tell if a short word fits in an open space, vertically" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("cat", [0,0], false)).must_equal(true)
  end

  it "Tell if a short word fits in a middle open space, vertically" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("cat", [5,7], false)).must_equal(true)
  end

  it "Tell if a short word barely fits in an open space, horizontally" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("cat", [0,12], true)).must_equal(true)
  end

  it "Tell if a short word barely fits in an open space, vertically" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("cat", [12,0], false)).must_equal(true)
  end

  it "Tell if a short word hangs off the board, horizontally" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("dogs", [0,12], true)).must_equal(false)
  end

  it "Tell if a short word hangs off the board, vertically" do
      board = Scrabble::Board.new
    expect(board.can_fit_on_board?("dogs", [12,0], false)).must_equal(false)
  end

  it "Check if a word is correctly stored on the board when placed there horizontally" do
    board = Scrabble::Board.new
    board.play_word_on_board("cat", [0,0], true)
    expect(board.board[0][0]).must_equal("C")
    expect(board.board[0][1]).must_equal("A")
    expect(board.board[0][2]).must_equal("T")
  end

  it "Check if a word is correctly stored on the board when placed there vertically" do
    board = Scrabble::Board.new
    board.play_word_on_board("cat", [11,2], false)
    expect(board.board[11][2]).must_equal("C")
    expect(board.board[12][2]).must_equal("A")
    expect(board.board[13][2]).must_equal("T")
  end

  # it "Tell if coordinates are valid" do
  #   expect(Scrabble::Board.can_fit_on_board?("dogs", [16,16], false)).must_raise(ArgumentError)

  # end
end
