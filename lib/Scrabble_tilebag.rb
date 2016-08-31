require_relative "../Scrabble_module"

DEFAULT_HASH = {"A" => 9,	"N" => 6, "B" => 2,	"O" => 8, "C" => 2,	"P" => 2,
"D" => 4,	"Q" => 1, "E" => 12,	"R" => 6, "F" => 2,	"S" => 4, "G" => 3,	"T" => 6,
"H" => 2,	"U" => 4, "I" => 9,	"V" => 2, "J" => 1,	"W" => 2, "K" => 1,	"X" => 1,
"L" => 4,	"Y" => 2, "M" => 2,	"Z" => 1}

class Scrabble::Tilebag

  attr_reader :tile_bag

  def initialize

    fill_default_tile_bag

  end

  #draw_tiles(num) returns num number of random tiles, removes the tiles from the default set

  def draw_tiles(num)

    # puts "Length of default_tiles: " + @tile_bag.length.to_s
    # print @tile_bag
    #
    # puts
    if num > 7
        raise ArgumentError
    end

    letters_picked = @tile_bag.sample(num)

    letters_picked.each do |tile|
      @tile_bag.delete_at(@tile_bag.index(tile))
    end

    # print "Letters picked: " + letters_picked.to_s + "\n"
    #
    # puts "NEW Length of default_tiles: " + @tile_bag.length.to_s
    # print @tile_bag
    #
    # puts

    return letters_picked

  end

  def tiles_remaining
    return @tile_bag.length
  end

  private

  def fill_default_tile_bag

    @tile_bag = []

    DEFAULT_HASH.each do |k,v|
      @tile_bag << Array.new(v, k)
    end

    @tile_bag = @tile_bag.flatten.sort

    puts @tile_bag

  end

end

my_tilebag = Scrabble::Tilebag.new
my_tilebag.draw_tiles(5)
