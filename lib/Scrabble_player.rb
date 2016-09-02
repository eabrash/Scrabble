require_relative "../Scrabble_module"
require_relative "Scrabble_scoring"
require_relative "Scrabble_tilebag"
require_relative "Scrabble_dictionary"

class Scrabble::Player
attr_writer :dictionary_on
attr_reader :name

  def initialize(name)
    @name = name
    @plays = []
    @won = false
    @tiles = []
    @dictionary_on = false
  end
#plays: returns an Array of the words played by the player
  def plays
    return @plays
  end

  def tiles
    if @tiles.length <= 7
      return @tiles
    else
      raise ArgumentError
    end
  end

  def draw_tiles(tile_bag)

    num_to_draw = 7 - @tiles.length

    @tiles.concat(tile_bag.draw_tiles(num_to_draw))

    return @tiles

  end

  # This is a "cheat" method that is useful for testing. We use it to set the
  # player's tiles to a known set so that we can tell whether tiles are
  # correctly being removed when the player plays.

  def set_tiles(preset_tiles)
    @tiles = preset_tiles
  end

  #do they have the tiles to play the word they want?
  def tiles_match_word?(word)
    tiles_to_check = @tiles.clone
      word.each_char do |letter|
        if tiles_to_check.index(letter) == nil
          return false
        else
        tiles_to_check.delete_at(tiles_to_check.index(letter))
        end
      end
      return true
  end

#Is the word they want to play in the dictionary?
  def dictionary_contains_word?(word)
     return Scrabble::Dictionary.check_word(word)
  end

#play(word): Adds the input word to the plays Array
# Returns false if player has already won
# Returns the score of the word
  def play(word)
    word.upcase!
    if won? == false && tiles_match_word?(word) == true
      if dictionary_on == true
        if dictionary_contains_word(word) == false
          return false
        end
      end
       @plays << word
#delete the played tiles from the player's tile try (@tiles)
       word.each_char do |letter|
       @tiles.delete_at(@tiles.index(letter))
        end

       return Scrabble::Scoring.score(word)
    else
      return false
    end
  end

#total_score: Returns the sum of scores of played words
  def total_score
    tot_score = 0
    @plays.each do |word|
      tot_score += Scrabble::Scoring.score(word)
    end
    return tot_score
  end

#won?: If the player has over 100 points, returns true, otherwise returns false
  def won?
    if total_score < 100
      return @won = false
    else
      return @won = true
    end
  end

#highest_scoring_word: Returns the highest scoring played word
  def highest_scoring_word
    return Scrabble::Scoring.highest_score_from(@plays)
  end
#highest_word_score: Returns the highest_scoring_word score
  def highest_word_score
    return Scrabble::Scoring.score(highest_scoring_word)
  end

end

# bob = Scrabble::Player.new("Bob")
# bob.draw_tiles(Scrabble::Tilebag.new)
# puts bob.tiles
# puts bob.play("a")
# puts bob.tiles

# bob.play("toad")
# puts "Total score: " + bob.total_score.to_s
# print "Plays: " + bob.plays.to_s + "\n"
