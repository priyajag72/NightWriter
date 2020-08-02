require_relative "test_helper"

class NightWriterTest < Minitest::Test

  def test_it_exists
    night_writer = NightWriter.new
    assert_instance_of NightWriter, night_writer
  end

  #def test_it_has_attributes
  #end

end
