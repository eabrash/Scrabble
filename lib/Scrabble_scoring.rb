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

    #print array_of_scores

    max_score = array_of_scores.max

    if array_of_scores.grep(max_score).size == 1

      #puts "Entered first if"

      return array_of_words[array_of_scores.index(max_score)]

    else

      #puts "Entered else"

      max_score_indices = []

      array_of_scores.each_with_index do |score, index|
        if score == max_score
          max_score_indices << index
        end
      end

      #print max_score_indices
      puts

      max_scoring_word = array_of_words[max_score_indices[0]]
      #puts max_scoring_word

      max_score_indices.each do |index|
        if array_of_words[index].length < max_scoring_word.length
          max_scoring_word = array_of_words[index]
        end
      end

      return max_scoring_word

    end

  end

end

#Scrabble::Scoring.highest_score_from(["gats", "bat", "aaaa"])
