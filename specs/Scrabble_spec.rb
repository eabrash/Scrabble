require_relative "../lib/Scrabble_scoring"
require_relative "Spec_helper"

describe "Testing Scrabble scoring" do

  it "Letter A is worth one point" do
    expect(Scrabble::Scoring.score("A").must_equal(1)
  end

end
