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

  ### Start of Recursive Level Order
  def current_level(root, level, node_array, &passed_block)
    return if root.nil?
    if level == 1
      node_array << root 
      if block_given?
        passed_block.call(root)
      end
    end
    if level > 1
      current_level(root.left, level-1, node_array, &passed_block)
      current_level(root.right, level-1, node_array, &passed_block)
    end
    node_array
  end

  def height(node)
    if node.nil?
      return 0
    else
      lheight = height(node.left)
      rheight = height(node.right)
      if lheight > rheight
        return lheight + 1
      else
        return rheight + 1
      end
    end
  end

  def recur_level_order(root, &passed_block)
    height = height(root)
    node_array = []
    for i in 1..height+1
      node_array = current_level(root, i, node_array, &passed_block)
    end
    node_array
  end
  ### End of Recursive Level Order

  def inorder(root, node_array=[], &passed_block)
    return nil if root.nil?
    inorder(root.left, node_array, &passed_block)
    node_array << root
    if block_given?
      passed_block.call(root)
    end
    inorder(root.right, node_array, &passed_block)
    node_array
  end

  def preorder(root, node_array=[], &passed_block)
    return nil if root.nil?
    node_array << root
    if block_given?
      passed_block.call(root)
    end
    preorder(root.left, node_array, &passed_block)
    preorder(root.right, node_array, &passed_block)
    node_array
  end

  def postorder(root, node_array=[], &passed_block)
    return nil if root.nil?
    postorder(root.left, node_array, &passed_block)
    postorder(root.right, node_array, &passed_block)
    node_array << root
    if block_given?
      passed_block.call(root)
    end
    node_array
  end

  def depth(root, node)
    return -1 if root.nil?
    dist = -1
    if root == node ||
      (dist = depth(root.left, node)) >= 0 ||
      (dist = depth(root.right, node)) >= 0
      return dist + 1
    end
    return dist 
  end

  def balanced?(root)
    return if root.nil?
    lheight = height(root.left) 
    rheight = height(root.right)

    if (lheight - rheight).abs >= 2
      return false
    else
      balanced?(root.left)
      balanced?(root.right)
    end
    return true
  end

  def rebalance(root)
    inorder_array = inorder(root).map {|node| node.data}
    print inorder_array
    Tree.new(inorder_array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end