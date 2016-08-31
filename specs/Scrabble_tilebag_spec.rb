require_relative "Spec_helper"
require_relative "../lib/Scrabble_tilebag"

describe "Testing Scrabble tilebag" do

  it "Pull the correct number of tiles or throw an error if you try to pull more than 7" do
    mytilebag = Scrabble::Tilebag.new
    expect(mytilebag.draw_tiles(1).length).must_equal(1)
    expect(mytilebag.draw_tiles(3).length).must_equal(3)
    expect(proc{mytilebag.draw_tiles(8).length}).must_raise ArgumentError
  end

  it "Reports correct number of tiles remaining before drawing tiles" do
    mytilebag = Scrabble::Tilebag.new
    expect(mytilebag.tiles_remaining).must_equal(98)
  end

  it "Reports correct number of tiles remaing after tiles are drawn" do
    mytilebag = Scrabble::Tilebag.new
    mytilebag.draw_tiles(5)
    expect(mytilebag.tiles_remaining).must_equal(93)
  end

  it "Reports that the tile drawn is deleted from the tilebag" do
    mytilebag = Scrabble::Tilebag.new
    early_tilebag = mytilebag.tile_bag.clone
    tile = mytilebag.draw_tiles(1)[0]
    late_tilebag = mytilebag.tile_bag
    expect(early_tilebag.count(tile)-late_tilebag.count(tile)).must_equal(1)
  end

  it "Reports that all tiles drawn are deleted from the tilebag" do
    mytilebag = Scrabble::Tilebag.new
    early_tilebag = mytilebag.tile_bag.clone
    tiles = mytilebag.draw_tiles(7)
    late_tilebag = mytilebag.tile_bag

    tiles.each do |tile|
      expect(early_tilebag.count(tile)-late_tilebag.count(tile)).must_equal(tiles.count(tile))
    end
  end

  # it "Won't let you draw tiles from an empty tile bag."
  # end
  #
  # it "Will give you the remaining tiles if you ask for more tiles than are in the bag."

end
