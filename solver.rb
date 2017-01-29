require_relative 'board'
require_relative 'tree'
require_relative 'tile'
require 'byebug'

class KnightSolver
  attr_reader :board, :graph, :current_position

  POTENTIAL_MOVES = [
    [-2, -1],
    [-2, 1],
    [-1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [1, 2]
  ]
  # debugger
  def initialize
    @board = Board.new
    @root = PolyTreeNode.new([0, 0])
    @visited_positions = [[0, 0]]
  end

  def new_move_positions(current_node)
    legal_moves = POTENTIAL_MOVES.select do |coords|
      is_legal_move?(compute_position(coords, current_node.value))
    end

    legal_moves.map! { |el| el = compute_position(el, current_node.value) }

    legal_moves.each do |move|
      @visited_positions << move
    end
    legal_moves
  end

  def build_tree
    queue = []
    queue << @root
    #debugger
    until queue.empty?
      current_node = queue.shift
      new_children = new_move_positions(current_node)
      new_children.each do |child_pos|
        new_child = PolyTreeNode.new(child_pos)
        queue << new_child if
        new_child.parent = current_node
      end
    end
  end

  def find_path(end_pos)
    build_tree
    final_node = @root.bfs(end_pos)
    path = trace_path_back(final_node)
    @board.render
    p path
  end

  def trace_path_back(final_node)
    path = []
    current_node = final_node

    while path.first != @root.value
      @board[current_node.value] = "K"
      @board.render
      path.unshift(current_node.value)
      current_node = current_node.parent unless current_node.parent.nil?
      sleep(0.5)
      system('clear')
    end
    path
  end

  def run(pos)
    find_path(pos)
  end

  def compute_position(coords, current_position)
    [current_position[0] + coords[0], current_position[1] + coords[1]]
  end

  def is_legal_move?(potential_move)
    within_range = potential_move.all? do |pos|
      (0..7).include?(pos)
    end
    visited = @visited_positions.include?(potential_move)

    within_range && !visited
  end
end

new_solver = KnightSolver.new
new_solver.run([7, 7])
