require_relative "file_reader_writer"

require 'matrix'
require 'csv'

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class Dictionary

  attr_reader :file_location, :reader

  def initialize(file_location)
    @file_location = file_location
    @reader = FileReaderWriter.new
  end

  def convert_csv_to_hash
    lowercase_eng_to_brl_dots_integer_hash = Hash.new
    CSV.foreach(@file_location, headers: false) do |row|
      lowercase_eng_to_brl_dots_integer_hash[row[0]] = row[1].to_i
    end
    lowercase_eng_to_brl_dots_integer_hash
  end

end
