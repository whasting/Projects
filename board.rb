class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, '.') }
  end

  def render
    print ' '
    8.times { |i| print " #{i} "}
    puts
    @grid.each_with_index do |row, idx|
      print idx
      row.each do |ele|
        print ' '
        print ele
        print ' '
      end
      puts
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, mark)
    row, col = pos
    @grid[row][col] = mark
  end
end
