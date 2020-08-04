require_relative "file_reader_writer"
require_relative "matrix"
require 'matrix'
require 'csv'

class Dictionary

  attr_reader :file_location, :reader

  def initialize(file_location)
    @file_location = file_location
    @reader = FileReaderWriter.new
  end

  def encode(text)
    if text.include?("\n")
      greater_than_forty_characters(text)
    else
      english_character_to_braille(text)
    end
    convert_to_cell(conditionals_end_line(text))
  end

  def convert_to_cell(text)
    row_suite
    @encoded_array = []
    by_char = text.scan(/.{6}/)
    by_char.each do |char|
      conditional_english_to_braile(char)
    end
    @encoded_array
  end

  # ============== HELPERS FOR CONVERT_TO_CELL ENCODE ==============
  def english_character_to_braille(text)
    convert_braille_matrix_to_string.each do |initial, conversion|
      text.gsub!(initial, conversion)
    end
  end

  def greater_than_forty_characters(text)
    text.each_line do |line|
      english_character_to_braille(text)
    end
  end

  def conditionals_end_line(text)
    text.gsub!(" ", "SPACEE")
    if text.include?("\n")
      text.gsub!("\n", "NEWLNE")
    else
      text += "\n"
      text.gsub!("\n", "NEWLNE")
    end
  end

  def conditional_english_to_braile(character)
    if character.include?("0" || ".")
      character_allocation(character)
    elsif character == "SPACEE"
      space_allocation
    else
      newline_allocation
      @encoded_array << print_single_line
      row_suite
    end
  end

  def row_suite
    @row1 = ""
    @row2 = ""
    @row3 = ""
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
    @row1 += ""
    @row2 += ""
    @row3 += ""
  end

  def print_single_line
    puts @row1
    puts @row2
    puts @row3
    return [@row1, @row2, @row3]
  end

  # ============== HELPERS FOR METHOD ENCODE ==============
  def convert_braille_matrix_to_string
    braille_horizontal_dot_hash = Hash.new

    convert_csv_to_hash.each do |key, value|
      @braille_board = Matrix[[".","."],[".","."],[".","."]]
      x = convert(value)
      braille_horizontal_dot_hash[key] = x
    end
    braille_horizontal_dot_hash
  end

  def convert_csv_to_hash
    braille_integer_hash = Hash.new
    CSV.foreach(@file_location, headers: false) do |row|
      braille_integer_hash[row[0]] = row[1].to_i
    end
    braille_integer_hash
  end

  def convert(integer)
    integer_array = integer.digits
    integer_array.each do |number|
      helper(number)
    end
    @braille_board.to_s.gsub(/Matrix|\[|\]|\,/, "").delete(" ")
  end

  def helper(integer)
    case integer
      when 1; @braille_board[0,0] = "0"
      when 2; @braille_board[1,0] = "0"
      when 3; @braille_board[2,0] = "0"
      when 4; @braille_board[0,1] = "0"
      when 5; @braille_board[1,1] = "0"
      when 6; @braille_board[2,1] = "0"
    end
  end

end
