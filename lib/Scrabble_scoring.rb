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
    return array_of_words[array_of_scores.index(array_of_scores.max)]
  end

end

# Scrabble::Scoring.score("A")
