require_relative "../Scrabble_module"

class Scrabble::Scoring

  LETTER_VALUES = {"A"=> 1, "E"=> 1, "I"=> 1, "O"=> 1, "U"=> 1, "L"=> 1, "N"=> 1, "R"=> 1, "S"=> 1, "T"=> 1,
  "D"=> 2, "G"=> 2,
  "B"=> 3, "C"=> 3, "M"=> 3, "P"=> 3,
  "F"=> 4, "H"=> 4, "V"=> 4, "W"=> 4, "Y"=> 4,
  "K"=> 5,
  "J"=> 8, "X"=> 8,
  "Q"=> 10, "Z"=> 10
   }

   def self.score(word)
    score = 0
    word.upcase!
    word.each_char do |letter|
      score += LETTER_VALUES[letter]
    end
# 50 point bonus for using all 7 tiles
    if word.length == 7
      score += 50
    end

    return score
   end

  def self.highest_score_from(array_of_words)
    array_of_scores = []

    array_of_words.each do |word|
      array_of_scores << self.score(word)
    end
#Combine the array_of_words and array_of_scores into a 2D array where the word and its score are stored in the same element of the primary array => [[word, score], [word2, score2]]
    array_of_word_scores = array_of_words.zip(array_of_scores)

    max_score = array_of_scores.max

#There are no tie scores
    if array_of_scores.grep(max_score).size == 1
#Find the in index of the max_score in the array_of_scores, then go to the same index in the array_of_word and return the associated word
      return array_of_words[array_of_scores.index(max_score)]
#There is more than one word with the same high score
    else
#Isolate the highest scoring words
      array_of_max_scoring_words_and_scores  = array_of_word_scores.select{|x| x[1]==max_score}
    end
#Find and compare the length of high score words
 winner = array_of_max_scoring_words_and_scores[0]

  array_of_max_scoring_words_and_scores.each do |x|
    #If the word length is 7, the word wins
      if x[0].length == 7
        return x[0]
      #If the word is shorter than the first word with a high score, it becomes the winning word
      elsif x[0].length < winner[0].length
        winner = x
      end
    end
      return winner[0]
  end

end
