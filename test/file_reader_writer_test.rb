require_relative "test_helper"

class FileReaderWriterTest < Minitest::Test

  def test_it_exists
    file = FileReaderWriter.new
    assert_instance_of FileReaderWriter, file
  end

  #def test_it_has_attributes
  #end

end
