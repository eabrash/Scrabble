require_relative "Spec_helper"
require_relative "../lib/Scrabble_dictionary"

describe "Testing Scrabble dictionary" do

  it "Should tell if a word is included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("cat")).must_equal(true)
  end

  it "Should tell if a word is NOT included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("qqqqqq")).must_equal(false)
  end

  it "Should tell variations of a word are included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("cats")).must_equal(true)
    expect(Scrabble::Dictionary.check_word("runs")).must_equal(true)
    expect(Scrabble::Dictionary.check_word("running")).must_equal(true)
    expect(Scrabble::Dictionary.check_word("runners")).must_equal(true)
  end

  it "Should say that word longer than 7 letters are included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("juggling")).must_equal(true)
  end

  it "Should say that an empty string is not included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("")).must_equal(false)
  end

  it "Should say that uppercase words are included in the dictionary" do
    expect(Scrabble::Dictionary.check_word("CAT")).must_equal(true)
  end
end
