require './tree.rb'

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
p test_array
tree1 = Tree.new(test_array)
tree1.pretty_print
tree1.insert(2)
tree1.pretty_print
tree1.delete(tree1.root, 67)
tree1.pretty_print
p "Data of node with data 3: #{tree1.find(tree1.root, 3).data}"

print_node = Proc.new {|node| print "#{node.data} "}

print "Iterative Level Order (No Block): "
tree1.level_order(tree1.root).map(&print_node)
puts

print "Iterative Level Order (Block Print): "
tree1.level_order(tree1.root, &print_node)
puts

print "Recursive Level Order (No Block): "
tree1.recur_level_order(tree1.root, &print_node)
puts

print "Recursive Level Order (Block Print): "
tree1.recur_level_order(tree1.root).map(&print_node)
puts
puts

print "Inorder Traversal (No Block): "
tree1.inorder(tree1.root).map(&print_node)
puts

print "Inorder Traversal (Block Print): "
tree1.inorder(tree1.root, [], &print_node)
puts
puts

print "Preorder Traversal (No Block): "
tree1.preorder(tree1.root).map(&print_node)
puts

print "Preorder Traversal (Block Print): "
tree1.preorder(tree1.root, [], &print_node)
puts
puts

print "Postorder Traversal (No Block): "
tree1.postorder(tree1.root).map(&print_node)
puts

print "Postorder Traversal (Block Print): "
tree1.postorder(tree1.root, [], &print_node)
puts
puts

puts "Tree Height: #{tree1.height(tree1.root)}"
puts "Distance from Root to Node 2: #{tree1.depth(tree1.root, tree1.find(tree1.root, 2))}"

puts "Tree 1 is balanced: #{tree1.balanced?(tree1.root)}"
tree1.insert(1.5)
tree1.pretty_print
puts "Tree 1 is balanced (after 1.5 insertion): #{tree1.balanced?(tree1.root)}"

tree1 = tree1.rebalance(tree1.root)
tree1.pretty_print

puts "Tree 1 is balanced (after rebalancing?): #{tree1.balanced?(tree1.root)}"