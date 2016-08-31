require_relative "Spec_helper"
require_relative "../lib/Scrabble_tilebag"

describe "Testing Scrabble tilebag" do

  it "Pull 1 tile" do
    mytilebag = Scrabble::Tilebag.new
    expect(mytilebag.draw_tiles(1).length).must_equal(1)
  end

end
