require_relative "../Scrabble_module"
require_relative "Scrabble_scoring"

class Scrabble::Player
attr_reader :name

  def initialize(name)
    @name = name
    @plays = []
  end
#plays: returns an Array of the words played by the player

  def plays
    return @plays
  end

  def play(word)
    @plays << word
  end

end


#plays: returns an Array of the words played by the player
#play(word): Adds the input word to the plays Array
# Returns false if player has already won
# Returns the score of the word
#total_score: Returns the sum of scores of played words
#won?: If the player has over 100 points, returns true, otherwise returns false
#highest_scoring_word: Returns the highest scoring played word
#highest_word_score: Returns the highest_scoring_word score
