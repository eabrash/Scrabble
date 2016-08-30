require_relative "../Scrabble_module"
require_relative "Scrabble_scoring"

class Scrabble::Player
attr_reader :name

  def initialize(name)
    @name = name
    @plays = []
    @won = false
  end
#plays: returns an Array of the words played by the player

  def plays
    return @plays
  end

#play(word): Adds the input word to the plays Array
# Returns false if player has already won
# Returns the score of the word
  def play(word)
    unless @won == true
       @plays << word
       return Scrabble::Scoring.score(word)
    else
      return false
    end
  end

#total_score: Returns the sum of scores of played words
  def total_score
    total_score = 0
    @plays.each do |word|
      total_score += Scrabble::Scoring.score(word)
    end
    return total_score
  end

end

bob = Scrabble::Player.new("Bob")
bob.play("frog")
bob.play("toad")
puts "Total score: " + bob.total_score.to_s
print "Plays: " + bob.plays.to_s + "\n"




#won?: If the player has over 100 points, returns true, otherwise returns false
#highest_scoring_word: Returns the highest scoring played word
#highest_word_score: Returns the highest_scoring_word score
