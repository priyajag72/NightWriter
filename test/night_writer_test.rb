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

    assert_equal "hello turing\n", @night_writer.reader.reader
    assert_equal 13, @night_writer.character_count(:input)
    assert_equal "hello turing\n", @night_writer.reader.writer
    assert_equal 13, @night_writer.character_count(:output)
  end

  def test_it_can_print_to_terminal_io_confirmation_message
    @night_writer.reader.stubs(:input).returns("message.txt")
    @night_writer.reader.stubs(:output).returns("braille.txt")

    assert_equal "Created 'braille.txt' containing 13 characters", @night_writer.confirmation_message
  end

  def test_it_inherited_Dictionary_Class
    assert_equal "0000..", @night_writer.lower_dictionary.convert_text_english_to_braille("g")
    assert_equal "0.....0000..", @night_writer.lower_dictionary.convert_text_english_to_braille("ag")
  end

end
