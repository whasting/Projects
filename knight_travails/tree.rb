require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent_node
    return nil if parent_node.nil?
    unless parent_node.children.include?(self)
      parent_node.children << self
    end
  end

  def add_child(child_node)
    @children << child_node unless child_exists?(@children)
    child_node.parent = self
  end

  def remove_child(child_node)
    if @children.include?(child_node)
      child_node.parent = nil
      @children.delete(child_node)
    else
      raise "CHILD DOES NOT EXIST"
    end
  end

  def child_exists?(children_nodes)
    children_nodes.include?(self)
  end

  def dfs(target_value)
    # debugger
    return self if target_value == self.value

    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = []
    return self if self.value == target_value

    queue << self

    # debugger
    until queue.length == 0
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each do |child|
        return child if child.value == target_value
        queue << child
      end
    end
    nil
  end
end
