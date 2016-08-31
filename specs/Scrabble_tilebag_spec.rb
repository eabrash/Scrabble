require_relative "Spec_helper"
require_relative "../lib/Scrabble_tilebag"

describe "Testing Scrabble tilebag" do

  it "Pull 1 tile" do
    mytilebag = Scrabble::Tilebag.new
    expect(mytilebag.draw_tiles(1).length).must_equal(1)
  end

  it "Reports correct number of tiles remaining before drawing tiles" do
    mytilebag = Scrabble::Tilebag.new
    expect(mytilebag.tiles_remaining).must_equal(98)
  end

  it "Reports correct number of tiles remaing after tiles are drawn"do
    mytilebag = Scrabble::Tilebag.new
    mytilebag.draw_tiles(5)
    expect(mytilebag.tiles_remaining).must_equal(93)
  end
end
