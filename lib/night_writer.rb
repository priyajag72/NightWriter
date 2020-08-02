require_relative "file_reader_writer"

class NightWriter < FileReaderWriter

  def confirmation_message
    require "pry"; binding.pry
  end

end
