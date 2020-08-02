require_relative "file_reader_writer"

class NightWriter

  attr_reader :reader

  def initialize
    @reader = FileReaderWriter.new
  end

  def file_input
    @reader.reader
  end

  def file_output
    @reader.writer
  end

  def character_count(io)
    case
      when :input
        @reader.input_character_count
      when :output
        @reader.output_character_count
    end
  end

  def confirmation_message
    "Created '#{@reader.output}' containing #{character_count(:output)} characters"
  end

end

# x = NightWriter.new
# x.confirmation_message
