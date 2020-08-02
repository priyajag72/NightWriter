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

    assert_equal "Hello Turing!\n", @file.reader
    assert_equal 14, @file.input_character_count
  end
end
