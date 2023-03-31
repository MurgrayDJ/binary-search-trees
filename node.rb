#Author: Murgray D. John
#Date: 3/31/2023
#Pupose: To create node objects for a balanced Binary Search Tree

class Node
  attr_reader @data 
  attr_accessor @left
  attr_accessor @right

  def initialize(data)
    @data = data 
    @left = null
    @right = null
  end
end