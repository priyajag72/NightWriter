require_relative "test_helper"

class FileReaderWriterTest < Minitest::Test

  def setup
    @file = FileReaderWriter.new
  end

  def test_it_exists
    assert_instance_of FileReaderWriter, @file
  end

  def test_it_can_read_and_get_details_from_input_txt_file
    @file.stubs(:input).returns("message.txt")

    assert_equal "hello turing\n", @file.reader
    assert_equal 13, @file.input_character_count
  end

  def test_it_can_write_a_new_file_and_copy_from_input
    @file.stubs(:input).returns("message.txt")
    @file.stubs(:output).returns("braille.txt")

    assert_equal File, @file.creator.class
    assert_equal "hello turing\n", @file.writer
    assert_equal 13, @file.output_character_count
  end
end
