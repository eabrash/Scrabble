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

    array_of_word_scores = array_of_words.zip(array_of_scores)
    # print array_of_word_scores

    max_score = array_of_scores.max
# There is a bonus for words that are seven letters. If the top score is tied between multiple words and one used all seven letters, choose the one with seven letters over the one with fewer tiles.

#There are no tie scores
    if array_of_scores.grep(max_score).size == 1

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
      end #of condtional in do
    end #of do
      return winner[0]
  end#of array of words method

end#of class

#Scrabble::Scoring.highest_score_from(["gats", "bat", "aaaa"])
