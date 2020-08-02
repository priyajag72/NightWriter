class FileReaderWriter

  attr_reader :input, :output

  def initialize
    @input = ARGV[0]
    @output = ARGV[1]
  end

  def reader
    File.open(input) { |file| file.read() }
  end
end
