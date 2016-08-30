require_relative "../lib/Scrabble_scoring"
require_relative "Spec_helper"

describe "Testing Scrabble scoring" do

  it "Letter A is worth one point" do
    expect(Scrabble::Scoring.score("A")).must_equal(1)
  end

  it "A two-letter word is correctly scored" do
    expect(Scrabble::Scoring.score("WE")).must_equal(5)
  end

  it "A word with seven letters gets a 50-point bonus" do
    expect(Scrabble::Scoring.score("AAAAAAA")).must_equal(57)
  end

end
