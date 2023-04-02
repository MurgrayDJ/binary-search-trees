#Author: Murgray D. John
#Date: 3/31/2023
#Pupose: To create node objects for a balanced Binary Search Tree

class Node
  attr_reader :data 
  attr_accessor :left
  attr_accessor :right
  include Comparable

  def initialize(data)
    @data = data 
    @left = nil
    @right = nil
  end

  def <=>(other_node)
    @data <=> other_node.data
  end
end

# node1 = Node.new(1)
# node2 = Node.new(2)

# puts node1 <=> node2

# node3 = Node.new(2)

# puts node2 <=> node3