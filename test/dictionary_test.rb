# Capital letters just have a dot6 before the character or a double dot6 before the word

require_relative "test_helper"

class DictionaryTest < Minitest::Test
  def setup
    lowercase = "./dictionary/lowercase_to_international_braille.csv"
    @dictionary = Dictionary.new(lowercase)

  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end

  def test_it_has_attributes
    assert_equal "./dictionary/lowercase_to_international_braille.csv", @dictionary.file_location

    @dictionary.reader.stubs(:input).returns("message.txt")
    assert_equal FileReaderWriter, @dictionary.reader.class

    assert_equal 13, @dictionary.reader.input_character_count
  end

  def test_it_can_convert_csv_to_braille_dots_integer_hash
    assert_equal 1, @dictionary.convert_csv_to_hash["a"]
    assert_equal 1346, @dictionary.convert_csv_to_hash["x"]
  end

end
