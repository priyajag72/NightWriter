require_relative "test_helper"

class NightReaderTest < Minitest::Test

  def setup
    @night_reader = NightReader.new
  end

  def test_it_exists
    assert_instance_of NightReader, @night_reader
  end

  def test_it_has_attributes
    @night_reader.reader.stubs(:input).returns("braille.txt")
    @night_reader.reader.stubs(:output).returns("message.txt")

    assert_equal "0.0.0.0.0.  .0  0.00  000..00000  000.0.  000.0..000  000.0.0.0.00.00.0..0\n00.00.0..0  0.  ....  00.00..000  0..000  0..00000.0  ..00..00....00.0000.\n....0.0.0.  ..  ..0.  ..0...0...  ..0.0.  ..0.0.0.00  ......0.....0...0.0.\n", @night_reader.reader.reader

    assert_equal 225, @night_reader.reader.character_count(@night_reader.reader.input)
    # assert_equal 225, @night_reader.reader.input_character_count
  end

  def test_it_inherits_from_dictionary
    assert_equal Dictionary, @night_reader.lower_dictionary.class
  end

end
