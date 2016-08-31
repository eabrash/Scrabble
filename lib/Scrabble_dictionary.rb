require_relative "../Scrabble_module"
require "csv"

class Scrabble::Dictionary

    @@dictionary = CSV.read("./dictionary.csv").flatten

    def self.check_word(word)
      return @@dictionary.include?(word.downcase)
    end

end
