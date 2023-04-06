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

  def insert(data)
    new_node = Node.new(data)
    prev_node = nil
    curr_node = @root
    if @root.nil?
      @root = new_node
    else
      until curr_node.nil?
        if new_node.data > curr_node.data
          prev_node = curr_node
          curr_node = curr_node.right
        else
          prev_node = curr_node
          curr_node = curr_node.left
        end
      end
      if new_node.data > prev_node.data
        prev_node.right = new_node
      else
        prev_node.left = new_node
      end
    end
  end

  def min_value(root)
    curr_min = root.data
    until root.left.nil?
      curr_min = root.left.data
      root = root.left
    end
    curr_min
  end

  def delete(root, data)
    if root.nil?
      return root
    elsif data < root.data
      root.left = delete(root.left, data)
    elsif data > root.data
      root.right = delete(root.right, data)
    else
      if root.left.nil?
        return root.right
      elsif root.right.nil?
        return root.left
      end
      root.data = min_value(root.right)
      root.right = delete(root.right, root.data)
    end
    root
  end

  def find(curr_node, value)
    found_node = nil
    if curr_node.nil?
      nil
    elsif curr_node.data == value
      curr_node
    else
      result = find(curr_node.left, value)
      unless result.nil? 
        found_node = result
        return found_node
      end
      result = find(curr_node.right, value)
      unless result.nil? 
        found_node = result
        return found_node
      end
    end
  end

  def level_order(root, &passed_block)
    return if root.nil? 
    node_queue = [root]
    level_order_array = []
    until node_queue.empty?
      curr_node = node_queue.shift
      level_order_array.push(curr_node)
      if block_given?
        passed_block.call(curr_node)
      end
      node_queue.push(curr_node.left) unless curr_node.left.nil? 
      node_queue.push(curr_node.right) unless curr_node.right.nil? 
    end
    level_order_array
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
tree1.insert(2)
tree1.pretty_print
tree1.delete(tree1.root, 67)
tree1.pretty_print
p tree1.find(tree1.root, 3).data
#print_node = Proc.new {|node| puts node.data}
#tree1.level_order(tree1.root, &print_node)
p tree1.level_order(tree1.root).map {|node| node = node.data}