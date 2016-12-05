require_relative "Spec_helper"
require_relative "../lib/Scrabble_special_board"

describe "Testing Special (includes double, triple letter and word scores) Scrabble board" do

  it "Correctly scores a word played on non-special spots." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("cat", [0,4], true)).must_equal(5)
  end

  it "Correctly scores a word played on a triple word score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("cat", [0,0], true)).must_equal(15)
  end

  it "Correctly scores a word played on a double word score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("cat", [1,0], true)).must_equal(10)
  end

  it "Correctly scores a word played on a double letter score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("cat", [0,3], false)).must_equal(8)
  end

  it "Correctly scores a word played on a triple letter score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("cat", [9,1], false)).must_equal(11)
  end

  it "Correctly scores a word played on a triple word and double letter score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("toad", [0,0], true)).must_equal(21)
  end

  it "Correctly scores a word played on a double word and triple letter score spot." do
    board = Scrabble::Board.new
    expect(board.score_from_special_board("toads", [1,1], true)).must_equal(16)
  end

  it "Correctly scores a word played on a double word and double letter score spot." do
    board = Scrabble::Board.new
      expect(board.score_from_special_board("toads", [11,3], true)).must_equal(14)
  end

  it "Correctly identifies that a word in the middle of a fresh board would not be adjacent to any neighbors." do
    board = Scrabble::Board.new
    expect(board.touches_other_letters?("CAT", [4,7], false)).must_equal([])
  end

  it "Correctly identifies that a word adjacent to another word in the middle of the board would have a neighbor." do
    board = Scrabble::Board.new
    board.play_word_on_board("cat", [4,7], false)
    expect(board.touches_other_letters?("NT", [5,8], true)).must_equal([[5,7]])
  end

  it "Correctly identifies that a word in the middle of a fresh board would not cover any existing tiles." do
    board = Scrabble::Board.new
    expect(board.are_spots_available?("CAT", [4,7], false)).must_equal(true)
  end

  it "Correctly identifies that a word played on top of an existing word would cover other tiles." do
    board = Scrabble::Board.new
    board.play_word_on_board("cat", [4,7], false)
    expect(board.are_spots_available?("CAT", [4,7], false)).must_equal(false)
  end

end
