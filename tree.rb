#Author: Murgray D. John
#Date: 3/31/2023
#Purpose: To create balanced binary search trees

class Tree
  attr_accessor :root

  def initialize(sorted_array)
    @root = build_tree(sorted_array)
  end
end