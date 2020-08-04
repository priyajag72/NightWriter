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

    assert_equal "0.0.0.0.0.  .0  0.00  000..00000  000.0.  000.0..000  000.0.0.0.00.00.0..0\n00.00.0..0  0.  ....  00.00..000  0..000  0..00000.0  ..00..00....00.0000.\n....0.0.0.  ..  ..0.  ..0...0...  ..0.0.  ..0.0.0.00  ......0.....0...0.0.\n0.0.0.0.  .00.  .0  0.00  0.0.000000  .0.0.00.  .00.0.0.00.000\n00.000.0  0..0  0.  ....  00..0.0..0  000.0000  0..00..0.000.0\n....0...  0.0.  ..  ..0.  ....0.0.00  .0..0...  0...00..0.0.00\n", @night_reader.reader.reader

    assert_equal 414, @night_reader.character_count(:input)
  end

  def test_it_inherits_from_dictionary
    assert_equal Dictionary, @night_reader.lower_dictionary.class
  end

  def test_it_can_convert_back_to_english
    @night_reader.reader.stubs(:input).returns("braille.txt")
    @night_reader.reader.stubs(:output).returns("message.txt")

    assert_equal "Created 'message.txt' containing 414 characters", @night_reader.encode_to_english
  end

end
