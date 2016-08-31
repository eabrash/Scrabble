require_relative "../Scrabble_module"

DEFAULT_HASH = {"A" => 9,	"N" => 6, "B" => 2,	"O" => 8, "C" => 2,	"P" => 2,
"D" => 4,	"Q" => 1, "E" => 12,	"R" => 6, "F" => 2,	"S" => 4, "G" => 3,	"T" => 6,
"H" => 2,	"U" => 4, "I" => 9,	"V" => 2, "J" => 1,	"W" => 2, "K" => 1,	"X" => 1,
"L" => 4,	"Y" => 2, "M" => 2,	"Z" => 1}

class Scrabble::Tilebag

  def initialize

    @default_tiles = []
    @default_tiles = fill_default_tile_bag

  end

  private

  def fill_default_tile_bag

    DEFAULT_HASH.each do |k,v|
      @default_tiles << Array.new(v, k)
    end

    @default_tiles = @default_tiles.flatten.sort

    print @default_tiles

  end

end

my_tilebag = Scrabble::Tilebag.new
