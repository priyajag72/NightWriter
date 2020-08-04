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
    if !text[/\p{L}/]
      braille_to_english(text)
    elsif text.include?("\n")
      greater_than_forty_characters(text)
      convert_to_cell(conditionals_end_line(text))
    else
      english_character_to_braille(text)
      convert_to_cell(conditionals_end_line(text))
    end
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
  # ============== HELPERS FOR ITERATON 3 ENCODE ==============
  def braille_to_english(text)
    horizontal_braille_hash ={}
    character_counter = 1
    previous_character = 0
    x = convert_from_braille_string_to_braille_integer(text)
    x.each do |line_from_text, row1_row2_row3|
      stop_when = ((row1_row2_row3[0].chomp.size) + 2) / 2
      while character_counter < stop_when do
        row1 = row1_row2_row3[0]
        row2 = row1_row2_row3[1]
        row3 = row1_row2_row3[2]
        if previous_character == 0
          horizontal_braille_hash[character_counter] = row1.slice(0..1) + row2.slice(0..1) + row3.slice(0..1)
          2.times {row1[0] = ''; row2[0] = ''; row3[0] = ''}
          character_counter += 1
        else
          new_line = previous_character + 1
          horizontal_braille_hash[new_line] = "\n"
          horizontal_braille_hash[(new_line + character_counter)] = row1.slice(0..1) + row2.slice(0..1) + row3.slice(0..1)
          2.times {row1[0] = ''; row2[0] = ''; row3[0] = ''}
          character_counter += 1
        end
      end
      previous_character = (character_counter - 1)
      character_counter = 1
    end
    x = convert_braille_matrix_to_string
    x[" "] = "------"
    x["\n"] = "\n"

    hash = {}
    y = horizontal_braille_hash
    y.each do |k,v|
      hash[k] = x.key(v)
    end
    x = hash.values.join('') + "\n"
    return x
  end

  def convert_from_braille_string_to_braille_integer(text)
    text.gsub!("  ", "--")
    braille_text_to_array = text.split(/\n/)
    braille_line_hash = {}
    line_counter = 1
    x = braille_text_to_array.each_slice(3).to_a
    x.each do |braille_row1_row2_row3|
      braille_line_hash["line ##{line_counter}"] = braille_row1_row2_row3
      line_counter += 1
    end
    braille_line_hash
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
