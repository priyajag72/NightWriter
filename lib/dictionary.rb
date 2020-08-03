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
    @blank_three_by_two = Matrix[[".","."],[".","."],[".","."]]
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
      case number
        when 1
          @blank_three_by_two[0,0] = "0"
        when 2
          @blank_three_by_two[1,0] = "0"
        when 3
          @blank_three_by_two[2,0] = "0"
        when 4
          @blank_three_by_two[0,1] = "0"
        when 5
          @blank_three_by_two[1,1] = "0"
        when 6
          @blank_three_by_two[2,1] = "0"
      end
    end
    @blank_three_by_two
  end

  # def convert_braille_to_string
  #   braille_matrix_to_string = Hash.new
  #   convert_csv_to_hash.each do |english_letter, braille_matrix|
  #     braille_board = Matrix[[".","."],[".","."],[".","."]]
  #     x = convert(braille_matrix).to_s.gsub(/Matrix|\[|\]|\,/, "").delete(" ")
  #     braille_matrix_to_string[english_letter] = x
  #   end
  #   braille_matrix_to_string
  # end



end
