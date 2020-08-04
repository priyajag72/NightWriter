require_relative "test_helper"

class NightWriterTest < Minitest::Test

  def setup
    @night_writer = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @night_writer
  end

  def test_it_has_attributes
    @night_writer.reader.stubs(:input).returns("message.txt")
    @night_writer.reader.stubs(:output).returns("braille.txt")

    assert_equal "hello i am going for forty characters\nhere so i am happy with seventy\n", @night_writer.reader.reader
    assert_equal 70, @night_writer.character_count(:input)
    assert_equal 70, @night_writer.character_count(:output)
  end

  def test_it_can_print_braille_characters_correctly
    @night_writer.reader.stubs(:input).returns("message.txt")
    @night_writer.reader.stubs(:output).returns("braille.txt")

    assert_equal "Created 'braille.txt' containing 70 characters", @night_writer.encode_to_braille
  end

end
