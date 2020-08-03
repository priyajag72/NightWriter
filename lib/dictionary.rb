require 'matrix'
require 'csv'

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class Dictionary

  def initialize(file_location)
    @file_location = file_location
  end
end
