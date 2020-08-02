require_relative "file_reader_writer"

class NightWriter

  attr_reader :reader

  def initialize
    @reader = FileReaderWriter.new
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
    @reader.creator
    @reader.writer
    "Created '#{@reader.output}' containing #{character_count(:output)} characters"
  end

end

x = NightWriter.new
puts x.confirmation_message
