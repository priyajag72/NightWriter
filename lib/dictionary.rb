require_relative "file_reader_writer"
require_relative "matrix"
require 'csv'

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

  def convert_text_english_to_braille(text)
    convert_braille_matrix_to_string.each do |character, braille_string|
      text.gsub!(character, braille_string)
    end
    text
  end

  def encode(text)
    convert_braille_matrix_to_string.each do |k,v|
      text.gsub!(k, v)
    end
    text.gsub!(" ", "SPACEE")
    text.gsub!("\n", "NEWLNE")
    convert_to_cell_row1_to_row3(text)
  end

  def convert_to_cell_row1_to_row3(text)
    by_char = text.scan(/.{6}/)
    @row1 = ""
    @row2 = ""
    @row3 = ""
    by_char.each do |char|
      if char == "SPACEE"
        space_allocation
      elsif char == "NEWLNE"
        newline_allocation
      else
        character_allocation(char)
      end
    end
    print_character
  end

  def character_allocation(char)
    @row1 += char[0]+char[1]
    @row2 += char[2]+char[3]
    @row3 += char[4]+char[5]
  end

  def space_allocation
    @row1 += "  "
    @row2 += "  "
    @row3 += "  "
  end

  def newline_allocation
    @row1 += "\n"
    @row2 += "\n"
    @row3 += "\n"
  end

  def print_character
    puts @row1
    puts @row2
    puts @row3
    return [@row1, @row2, @row3]
  end

end
