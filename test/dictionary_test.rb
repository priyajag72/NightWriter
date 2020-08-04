# Capital letters just have a dot6 before the character or a double dot6 before the word

require_relative "test_helper"

class DictionaryTest < Minitest::Test
  def setup
    @lowercase = "./dictionary/lowercase_to_international_braille.csv"
    @dictionary = Dictionary.new(@lowercase)
  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end

  def test_it_has_attributes
    assert_equal @lowercase, @dictionary.file_location
    assert_instance_of FileReaderWriter, @dictionary.reader
  end

  def test_it_can_use_a_local_dictionary_and_encode
    assert_equal [["0.0.0.0.0.", "00.00.0..0", "....0.0.0."]], @dictionary.encode("hello")
  end
end
