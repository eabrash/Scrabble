require_relative "Spec_helper"
require_relative "../lib/Scrabble_scoring"
require_relative "../lib/Scrabble_player"

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

  it "Confirm that a winner cannot continue playing when they win in one step" do
    robert = Scrabble::Player.new("Robert")
    robert.play("ZZZZZZZ")
    expect(robert.play("Q")).must_equal(false)
  end

  it "Test ability to return highest scoring played word" do
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

end
#----------------------------------------------------
describe "Testing Scrabble scoring" do

  it "Letter A is worth one point" do
    expect(Scrabble::Scoring.score("A")).must_equal(1)
    expect(Scrabble::Scoring.score("X")).must_equal(8)
  end

  it "A multiple-letter word is correctly scored" do
    expect(Scrabble::Scoring.score("WE")).must_equal(5)
    expect(Scrabble::Scoring.score("ORANGE")).must_equal(7)
  end

  it "A lowercase multiple-letter word is correctly scored" do
    expect(Scrabble::Scoring.score("we")).must_equal(5)
    expect(Scrabble::Scoring.score("quiz")).must_equal(22)
  end

  it "A word with seven letters gets a 50-point bonus" do
    expect(Scrabble::Scoring.score("AAAAAAA")).must_equal(57)
    expect(Scrabble::Scoring.score("seventy")).must_equal(63)
  end

  it "The highest score from array of words, no tie" do
    expect(Scrabble::Scoring.highest_score_from(["cat", "fox", "xxxxxxx"])).must_equal("XXXXXXX")
    expect(Scrabble::Scoring.highest_score_from(["quest", "LIZARDS", "at", "zipper"])).must_equal("LIZARDS")
  end

  it "If there is a tie, it's better to use fewer tiles (favor the shorter word)" do
    expect(Scrabble::Scoring.highest_score_from(["gats", "bat", "aaaa"])).must_equal("BAT")
    expect(Scrabble::Scoring.highest_score_from(["quiz", "aaaaa", "qzd", "eeeee"])).must_equal("QZD")
  end

  it "If there is a three-way tie, the word with fewer tiles is chosen" do
    expect(Scrabble::Scoring.highest_score_from(["hi", "gats", "bat", "aaaa"])).must_equal("HI")
    expect(Scrabble::Scoring.highest_score_from(["eee", "aaa", "fff", "zg", "bbbb"])).must_equal("ZG")
  end

  it "If there is a 7-letter word that is tied with a shorter word, the 7-letter word wins" do
    expect(Scrabble::Scoring.highest_score_from(["aaaaaay", "bat", "zzzzzz", "aaaa"])).must_equal("AAAAAAY")
    expect(Scrabble::Scoring.highest_score_from(["eeee", "pasters", "fasters", "qqqqqq"])).must_equal("FASTERS")
  end

  it "If multiple words have the same score and same length, the first one wins" do
    expect(Scrabble::Scoring.highest_score_from(["bat", "pat", "mat", "cat"])).must_equal("BAT")
    expect(Scrabble::Scoring.highest_score_from(["AAAAAAA", "pat", "mat", "EEEEEEE"])).must_equal("AAAAAAA")
  end

end
