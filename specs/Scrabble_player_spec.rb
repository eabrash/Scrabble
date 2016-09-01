require_relative "Spec_helper"
require_relative "../lib/Scrabble_player"
require_relative "../lib/Scrabble_tilebag"

describe "Testing Scrabble player" do

  it "Returns the player's name" do
    expect(Scrabble::Player.new("Bob").name).must_equal("Bob")
  end

  it "Return the word(s) played by the player" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["F","R","O","G"])
    bob.play("frog")
    bob.set_tiles(["T","O","A","D"])
    bob.play("toad")
    expect(bob.plays).must_equal(["FROG", "TOAD"])
  end

  it "Test ability of play to return a word score" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["F","R","O","G"])
    expect(bob.play("frog")).must_equal(8)
    bob.set_tiles(["T","O","A","D"])
    expect(bob.play("toad")).must_equal(5)
  end

  it "Test ability to return player's total score" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["F","R","O","G"])
    bob.play("frog")
    bob.set_tiles(["T","O","A","D"])
    bob.play("toad")
    expect(bob.total_score).must_equal(13)
    bob.set_tiles(["B","A","T"])
    bob.play("bat")
    expect(bob.total_score).must_equal(18)
    bob.set_tiles(["Q","U","I","Z"])
    bob.play("quiz")
    expect(bob.total_score).must_equal(40)
  end

  it "Test ability of player to win" do
    robert = Scrabble::Player.new("Robert")
    expect(robert.won?).must_equal(false)
    robert.set_tiles(["Z","Z","Z","Z","Z","Z","Z"])
    robert.play("ZZZZZZZ")
    expect(robert.won?).must_equal(true)
  end

  it "Confirm that a winner cannot continue playing when they win incrementally" do
    robert = Scrabble::Player.new("Robert")
    robert.set_tiles(["B","O","X"])
    robert.play("BOX")
    robert.set_tiles(["Q","U","I","C","K"])
    robert.play("QUICK")
    robert.set_tiles(["Z","Z","Z","Z","Z","Z","Z"])
    robert.play("ZZZZ")
    robert.set_tiles(["Q","J"])
    robert.play("QJ")
    robert.set_tiles(["K","H","A"])
    robert.play("KHA")
    robert.set_tiles(["C","A","T"])
    expect(robert.play("CAT")).must_equal(false)
  end

  it "Confirm that a winner cannot continue playing when they win in one step" do
    robert = Scrabble::Player.new("Robert")
    robert.set_tiles(["Z","Z","Z","Z","Z","Z","Z"])
    robert.play("ZZZZZZZ")
    expect(robert.play("Q")).must_equal(false)
  end

  it "Confirm that an empty play returns a score of zero" do
    robert = Scrabble::Player.new("Robert")
    robert.set_tiles([""])
    expect(robert.play("")).must_equal(0)
  end

  it "Confirm that an empty word is still entered into the array of plays" do
    robert = Scrabble::Player.new("Robert")
    robert.set_tiles([""])
    robert.play("")
    robert.set_tiles(["D","O","G"])
    robert.play("dog")
    expect(robert.plays).must_equal(["", "DOG"])
  end

  it "Test ability to return highest-scoring played word" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["F","R","O","G"])
    bob.play("frog")
    bob.set_tiles(["T","O","A","D"])
    bob.play("toad")
    expect(bob.highest_scoring_word).must_equal("FROG")
  end

  it "Test ability to return score of highest-scoring played word" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["F","R","O","G"])
    bob.play("frog")
    bob.set_tiles(["T","O","A","D"])
    bob.play("toad")
    expect(bob.highest_word_score).must_equal(8)
  end

  it "Test ability to correctly return the high-scoring word in case of ties" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["A","A","A","A","A","A","A"])
    bob.play("AAAAAAA")
    bob.set_tiles(["E","E","E","E","E","E","E"])
    bob.play("EEEEEEE")
    expect(bob.highest_scoring_word).must_equal("AAAAAAA")
  end

  it "Test ability to correctly return the high-scoring word in case of a six- and seven-letter word that are tied" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["E","E","E","E"])
    bob.play("eeee")
    bob.set_tiles(["F","A","S","T","E","R","S"])
    bob.play("fasters")
    bob.set_tiles(["Q","Q","Q","Q","Q","Q","Q"])
    bob.play("qqqqqq")
    expect(bob.highest_scoring_word).must_equal("FASTERS")
  end

  it "Player draws to have 7 tiles" do
    bob = Scrabble::Player.new("Bob")
    bob.draw_tiles(Scrabble::Tilebag.new)
    expect(bob.tiles.length).must_equal(7)
  end

  it "Player's drawn tiles match stored tiles" do
    bob = Scrabble::Player.new("Bob")
    drawn_tiles = bob.draw_tiles(Scrabble::Tilebag.new)
    expect(bob.tiles).must_equal(drawn_tiles)
  end

  it "Sets the players tiles to a preset group of tiles (cheat)" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["T","O","A","D"])
    expect(bob.tiles).must_equal(["T","O","A","D"])
  end

  it "Ensures the player can only play words if they have the correct tiles for that word" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["T","O","A","D","X"])
    expect(bob.play("TOAD")).must_equal(5)
  end

  it "Ensures played tiles are no longer in the player's tile tray" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["T","O","A","D","X"])
    bob.play("TOAD")
    expect(bob.tiles).must_equal(["X"])
  end

  it "Ensures a player can not play a word they don't have the tiles for" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["T","O","A","D","X"])
    expect(bob.play("FROG")).must_equal(false)
  end

  it "Ensures a player can not play a word they don't have the tiles for, and that those tiles are not removed from their tray" do
    bob = Scrabble::Player.new("Bob")
    bob.set_tiles(["T","O","A","D","X"])
    bob.play("FROG")
    expect(bob.tiles).must_equal(["T","O","A","D","X"])
  end

end
