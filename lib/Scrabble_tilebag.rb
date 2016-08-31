require_relative "../Scrabble_module"

DEFAULT_HASH = {"A" => 9,	"N" => 6, "B" => 2,	"O" => 8, "C" => 2,	"P" => 2,
"D" => 4,	"Q" => 1, "E" => 12,	"R" => 6, "F" => 2,	"S" => 4, "G" => 3,	"T" => 6,
"H" => 2,	"U" => 4, "I" => 9,	"V" => 2, "J" => 1,	"W" => 2, "K" => 1,	"X" => 1,
"L" => 4,	"Y" => 2, "M" => 2,	"Z" => 1}

class Scrabble::Tilebag

  def initialize

    fill_default_tile_bag

  end

  #draw_tiles(num) returns num number of random tiles, removes the tiles from the default set

  def draw_tiles(num)

    # puts "Length of default_tiles: " + @default_tiles.length.to_s
    # print @default_tiles
    #
    # puts

    letters_picked = @default_tiles.sample(num)

    letters_picked.each do |tile|
      @default_tiles.delete_at(@default_tiles.index(tile))
    end

    # print "Letters picked: " + letters_picked.to_s + "\n"
    #
    # puts "NEW Length of default_tiles: " + @default_tiles.length.to_s
    # print @default_tiles
    #
    # puts

    return letters_picked

  end

  private

  def fill_default_tile_bag

    @default_tiles = []

    DEFAULT_HASH.each do |k,v|
      @default_tiles << Array.new(v, k)
    end

    @default_tiles = @default_tiles.flatten.sort

  end

end

my_tilebag = Scrabble::Tilebag.new
my_tilebag.draw_tiles(5)
