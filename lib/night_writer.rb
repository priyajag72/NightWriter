require_relative "dictionary"
require_relative "file_reader_writer"

class NightWriter < Dictionary # probably need a super class = encoder and everything inherits from it (built from methods in dictionary that don't belong)

  attr_reader :reader, :lower_dictionary, :upper_dictionary, :punctuation_dictionary, :numbers_dictionary

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

  def encode_to_braille
    message = @reader.reader
    low = @lower_dictionary
    braille_conversion = low.encode(message)
    # does this just encode for each kinda of dictionary and then write the final?? If so, that's suuuuper cool
    @reader.writer(braille_conversion)
    return confirmation_message
    # require "pry"; binding.pry
  end

end
#
# x = NightWriter.new
# puts x.confirmation_message
