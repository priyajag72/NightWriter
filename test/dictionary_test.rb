# Capital letters just have a dot6 before the character or a double dot6 before the word
# "./dictionary/lowercase_to_international_braille.csv"

require_relative "test_helper"

class DictionaryTest < Minitest::Test
  def setup
    lowercase = "./dictionary/lowercase_to_international_braille.csv"
    @dictionary = Dictionary.new(lowercase)

  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end
end
