require_relative "test_helper"

class NightWriterTest < Minitest::Test

  def setup
    @night_writer = NightWriter.new
  end

  def test_it_exists
    assert_instance_of NightWriter, @night_writer
  end

  def test_it_can_print_to_terminal_io_confirmation_message
    @night_writer.stubs(:input).returns("message.txt")
    @night_writer.stubs(:output).returns("braille.txt")

    assert_equal "Created 'braille.txt' containing 14 characters", @night_writer.confirmation_message
  end

end
