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
    @braille_board = Matrix[[".","."],[".","."],[".","."]]
  end

  def convert_csv_to_hash
    eng_and_brl_dots_integer_hash = Hash.new
    CSV.foreach(@file_location, headers: false) do |row|
      eng_and_brl_dots_integer_hash[row[0]] = row[1].to_i
    end
    eng_and_brl_dots_integer_hash
  end

  def convert(integer)
    integer_array = integer.digits
    integer_array.each do |number|
      helper(number)
    end
    @braille_board
  end

  def helper(integer)
    case integer
      when 1
        @braille_board[0,0] = "0"
      when 2
        @braille_board[1,0] = "0"
      when 3
        @braille_board[2,0] = "0"
      when 4
        @braille_board[0,1] = "0"
      when 5
        @braille_board[1,1] = "0"
      when 6
        @braille_board[2,1] = "0"
    end
  end

  def convert_braille_matrix_to_string
    lowercase_to_dot_hash = Hash.new
    convert_csv_to_hash.each do |key, value|
      @braille_board = Matrix[[".","."],[".","."],[".","."]]
      x = convert(value).to_s.gsub(/Matrix|\[|\]|\,/, "").delete(" ")
      lowercase_to_dot_hash[key] = x
    end
    lowercase_to_dot_hash
  end

end
