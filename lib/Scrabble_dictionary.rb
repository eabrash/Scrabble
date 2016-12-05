require_relative "../Scrabble_module"
require "csv"

class Scrabble::Dictionary

    @@dictionary = CSV.read("./dictionary.csv").flatten

    def self.check_word(word)
      return @@dictionary.include?(word.downcase)
    end

    def self.ends_in_e
      words_ending_in_e = []
      @@dictionary.each do |word|
        if word[-1,1] == "e"
          words_ending_in_e << word
          end
        end
     return words_ending_in_e.length
   end

end


print Scrabble::Dictionary.ends_in_e
