require 'scrabblestuff'
require 'csv'

solver = Scrabble::Solver.new
solver.load_dictionary

letters = "AAAAAAAAABBCCDDDDEEEEEEEEEEEEFFGGGHHIIIIIIIIIJKLLLLMMNNNNNNOOOOOOOOPPQRRRRRRSSSSTTTTTTUUUUVVWWXYYZ"

letters.downcase!

word_list = solver.find(letters).sort { |x,y| x.length <=> y.length }

word_list = word_list.delete_if {|word| word.length > 7 }

CSV.open("dictionary.csv", "w") do |csv|
  csv << word_list
end
