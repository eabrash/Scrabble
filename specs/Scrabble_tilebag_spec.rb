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

    # print "EARLY: " + early_tilebag.to_s + "\n"
    # print "Late: " + late_tilebag.to_s + "\n"
    # print "Tiles: " + tiles.to_s + "\n"

    tiles.each do |tile|
      expect(early_tilebag.count(tile)-late_tilebag.count(tile)).must_equal(tiles.count(tile))
    end

  end

end
