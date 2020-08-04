# require_relative "file_reader_writer"
# require_relative "dictionary"

class NightReader

  attr_reader :reader,
              :lower_dictionary,
              :upper_dictionary,
              :punctuation_dictionary,
              :numbers_dictionary

  def initialize
    @reader = FileReaderWriter.new

    lowercase = "./dictionary/lowercase_to_international_braille.csv"
    uppercase = "./dictionary/uppercase_to_international_braille.csv"
    punctuation = "./dictionary/punctuation_to_international_braille.csv"
    numbers = "./dictionary/numbers_to_international_braille.csv"

    @lower_dictionary = Dictionary.new(lowercase)
    @upper_dictionary = Dictionary.new(uppercase)
    @punctuation_dictionary = Dictionary.new(punctuation)
    @numbers_dictionary = Dictionary.new(numbers)
  end
end
