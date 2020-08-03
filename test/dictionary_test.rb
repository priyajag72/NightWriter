# Capital letters just have a dot6 before the character or a double dot6 before the word

require_relative "test_helper"

class DictionaryTest < Minitest::Test
dictionary/lowercase_to_international_braille.csv
  def setup
    @dictionary = Dictionary.new()

  end

  def test_it_exists
    assert_instance_of Dictionary, @dictionary
  end
end
