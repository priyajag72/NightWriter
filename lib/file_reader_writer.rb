class FileReaderWriter

  attr_reader :input, :output

  def initialize
    @input = ARGV[0]
    @output = ARGV[1]
  end

  def reader
    File.open(input) { |file| file.read() }
  end

  def input_character_count
    text = File.readlines(input).join
    text.length
  end

  def creator
    File.new("./#{output}", "w")
  end

  def writer
    creator
    File.open("./#{output}", "w") { |out_file| out_file.write(reader) }
    File.open(input) { |file| file.read() }
  end
end
