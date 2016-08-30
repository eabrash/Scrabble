require_relative "Spec_helper"
require_relative "../lib/Scrabble_scoring"


describe "Testing Scrabble scoring" do

  it "Letter A is worth one point" do
    expect(Scrabble::Scoring.score("A")).must_equal(1)
  end
  
  it "A two-letter word is correctly scored" do
    expect(Scrabble::Scoring.score("WE")).must_equal(5)
  end

  it "A lowercase two-letter word is correctly scored" do
    expect(Scrabble::Scoring.score("we")).must_equal(5)
  end

  it "A word with seven letters gets a 50-point bonus" do
    expect(Scrabble::Scoring.score("AAAAAAA")).must_equal(57)
  end

  it "The highest score from array of words, no tie" do
    expect(Scrabble::Scoring.highest_score_from(["cat", "fox", "xxxxxxx"])).must_equal("XXXXXXX")
  end

  it "If there is a tie, it's better to use fewer tiles (favor the shorter word)" do
    expect(Scrabble::Scoring.highest_score_from(["gats", "bat", "aaaa"])).must_equal("BAT")
  end

  it "If there is a three-way tie, the word with fewer tiles is chosen" do
    expect(Scrabble::Scoring.highest_score_from(["hi", "gats", "bat", "aaaa"])).must_equal("HI")
  end

  it "If there is a 7-letter word that is tied with a shorter word, the 7-letter word wins" do
    expect(Scrabble::Scoring.highest_score_from(["aaaaaay", "bat", "zzzzzz", "aaaa"])).must_equal("AAAAAAY")
  end

  it "If multiple words have the same score and same length, the first one wins" do
    expect(Scrabble::Scoring.highest_score_from(["bat", "pat", "mat", "cat"])).must_equal("BAT")
    expect(Scrabble::Scoring.highest_score_from(["AAAAAAA", "pat", "mat", "EEEEEEE"])).must_equal("AAAAAAA")
  end

end
