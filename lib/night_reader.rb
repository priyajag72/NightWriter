require_relative "file_reader_writer"
require_relative "dictionary"

class NightReader < Dictionary

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

  def character_count(io)
    case
      when :input
        @reader.input_character_count
      when :output
        @reader.output_character_count
    end
  end

  def confirmation_message
    "Created '#{@reader.output}' containing #{character_count(:output)} characters"
  end

  def encode_to_english
    message = @reader.reader
    low = @lower_dictionary
    conversion = low.encode(message)
    @reader.writer(conversion)
    return confirmation_message
  end
end
#
x = NightReader.new
x.encode_to_english
puts x.confirmation_message
