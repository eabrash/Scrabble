require_relative "Spec_helper"
require_relative "../lib/Scrabble_player"
require_relative "../lib/Scrabble_tilebag"

describe "Testing Scrabble player" do

  it "Returns the player's name" do
    expect(Scrabble::Player.new("Bob").name).must_equal("Bob")
  end

  it "Return the word(s) played by the player" do
    bob = Scrabble::Player.new("Bob")
    bob.play("frog")
    bob.play("toad")
    expect(bob.plays).must_equal(["FROG", "TOAD"])
  end

  it "Test ability of play to return a word score" do
    bob = Scrabble::Player.new("Bob")
    expect(bob.play("frog")).must_equal(8)
    expect(bob.play("toad")).must_equal(5)
  end

  it "Test ability to return player's total score" do
    bob = Scrabble::Player.new("Bob")
    bob.play("frog")
    bob.play("toad")
    expect(bob.total_score).must_equal(13)
    bob.play("bat")
    expect(bob.total_score).must_equal(18)
    bob.play("quiz")
    expect(bob.total_score).must_equal(40)
  end

  it "Test ability of player to win" do
    robert = Scrabble::Player.new("Robert")
    expect(robert.won?).must_equal(false)
    robert.play("ZZZZZZZ")
    expect(robert.won?).must_equal(true)
  end

  it "Confirm that a winner cannot continue playing when they win incrementally" do
    robert = Scrabble::Player.new("Robert")
    robert.play("BOX")
    robert.play("QUICK")
    robert.play("ZZZZ")
    robert.play("QJ")
    robert.play("KHA")
    expect(robert.play("CAT")).must_equal(false)
  end

  it "Confirm that a winner cannot continue playing when they win in one step" do
    robert = Scrabble::Player.new("Robert")
    robert.play("ZZZZZZZ")
    expect(robert.play("Q")).must_equal(false)
  end

  it "Confirm that an empty play returns a score of zero" do
    robert = Scrabble::Player.new("Robert")
    expect(robert.play("")).must_equal(0)
  end

  it "Confirm that an empty word is still entered into the array of plays" do
    robert = Scrabble::Player.new("Robert")
    robert.play("")
    robert.play("dog")
    expect(robert.plays).must_equal(["", "DOG"])
  end

  it "Test ability to return highest-scoring played word" do
    bob = Scrabble::Player.new("Bob")
    bob.play("frog")
    bob.play("toad")
    expect(bob.highest_scoring_word).must_equal("FROG")
  end

  it "Test ability to return score of highest-scoring played word" do
    bob = Scrabble::Player.new("Bob")
    bob.play("frog")
    bob.play("toad")
    expect(bob.highest_word_score).must_equal(8)
  end

  it "Test ability to correctly return the high-scoring word in case of ties" do
    bob = Scrabble::Player.new("Bob")
    bob.play("AAAAAAA")
    bob.play("EEEEEEE")
    expect(bob.highest_scoring_word).must_equal("AAAAAAA")
  end

  it "Test ability to correctly return the high-scoring word in case of a six- and seven-letter word that are tied" do
    bob = Scrabble::Player.new("Bob")
    bob.play("eeee")
    bob.play("fasters")
    bob.play("qqqqqq")
    expect(bob.highest_scoring_word).must_equal("FASTERS")
  end

  it "Player draws to have 7 tiles" do
    bob = Scrabble::Player.new("Bob")
    bob.draw_tiles(Scrabble::Tilebag.new)
    expect(bob.tiles.length).must_equal(7)
  end

  it "Player's drawn tiles match stored tiles" do
    bob = Scrabble::Player.new("Bob")
    drawn_tiles = bob.draw_tiles(Scrabble::Tilebag.new)
    expect(bob.tiles).must_equal(drawn_tiles)
  end

end
