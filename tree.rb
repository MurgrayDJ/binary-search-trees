#Author: Murgray D. John
#Date: 3/31/2023
#Purpose: To create balanced binary search trees

class Tree
  attr_accessor :root

  def initialize(sorted_array)
    @root = build_tree(sorted_array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end