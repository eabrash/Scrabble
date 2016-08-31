require_relative "../Scrabble_module"
require_relative "Scrabble_scoring"
require_relative "Scrabble_tilebag"

class Scrabble::Player

attr_reader :name

  def initialize(name)
    @name = name
    @plays = []
    @won = false
    @tiles = []
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

#play(word): Adds the input word to the plays Array
# Returns false if player has already won
# Returns the score of the word
  def play(word)
    if won? == false
       @plays << word
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

bob = Scrabble::Player.new("Bob")
bob.play("frog")
bob.play("toad")
puts "Total score: " + bob.total_score.to_s
print "Plays: " + bob.plays.to_s + "\n"
