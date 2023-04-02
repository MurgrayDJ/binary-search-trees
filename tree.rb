#Author: Murgray D. John
#Date: 3/31/2023
#Purpose: To create balanced binary search trees

require './node.rb'

class Tree
  attr_accessor :root

  def initialize(data_arr)
    @root = build_tree(data_arr)
  end

  def build_tree(data_arr, first=nil, last=nil)
    if first == nil && last == nil
      data_arr.sort!
      p data_arr
      data_arr.uniq!
      p data_arr
      first = 0
      last = data_arr.length-1
    elsif first > last
      return nil
    end
    mid = (first + last) / 2
    new_node = Node.new(data_arr[mid])
    new_node.left = build_tree(data_arr, first, mid-1)
    new_node.right = build_tree(data_arr, mid+1, last)
    new_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p test_array
tree1 = Tree.new(test_array)
tree1.pretty_print