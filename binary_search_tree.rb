class Node
  attr_accessor :data,:left,:right
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end


class Tree
  attr_accessor :arr,:root
  def initialize
    @arr = Array.new(10){rand(100)}.uniq.sort
    @root = nil
  end
  
  def build_tree(arr,start,end_arr)
    return nil if start > end_arr
    mid = (end_arr+start)/2
    root = Node.new(arr[mid])
    root.left = build_tree(arr,start,mid-1)
    root.right = build_tree(arr,mid+1,end_arr)
    @root = root
    return root
end 

def find(val)
  current = @root
  while current
    return current if val == current.data
    current.data > val ? current = current.left : current = current.right
  end
  nil
end

def level_order_recursive(node = @root,print_out = [])
  return if node.nil?
  print_out << node
  level_order_recursive(node.left,print_out) 
  level_order_recursive(node.right,print_out)
  if block_given?
    print_out.each{|node| yield node}
  else
   print_out
   end
end

def level_order
  queue = [@root] 
  print_out = []
  while !queue.empty?
    queue << queue[0].left if !queue[0].left.nil?
    queue << queue[0].right if !queue[0].right.nil?
    print_out << queue.shift
  end
  if block_given?
  print_out.each{|node| yield node}
else
  print_out
 end
end

def preorder(node = self.root,array = [])
  return if node.nil?
  if block_given?
  yield node 
  else
    array << node
  end
  preorder(node.left,array)
  preorder(node.right,array)
   array if !block_given?
end

def inorder(node = self.root ,array = [])
  return if node.nil?

  inorder(node.left,array)
  if block_given?
    yield node
  else
    array << node
  end
  inorder(node.right,array)
  array if !block_given?
end

def postorder(node = self.root, array = [])
  return if node.nil?

  postorder(node.left,array)
  postorder(node.right,array)
  if block_given?
    yield node
  else
    array << node
  end
  array if !block_given?
end

def height(node)
  max_height = []
  current = @root
  while current.data != node
    current.data > node ? current = current.left : current = current.right
  end
  found_node = current

  current_left_subtree = found_node.left
  current_right_subtree = found_node.right
  count_left = 0
  count_right = 0

  while current_left_subtree
    current_left_subtree.left.nil? ? current_left_subtree = current_left_subtree.right : current_left_subtree = current_left_subtree.left
    count_left+=1
  end
  max_height << count_left
  while current_right_subtree
    current_right_subtree.left.nil? ? current_right_subtree = current_right_subtree.right : current_right_subtree = current_right_subtree.left
    count_right+=1
  end
  max_height << count_right
  max_height.max
end

def height_recursive(node)
  
end

def depth(node)
  current = @root
  count = 0
  while current.data != node
    count+=1
    current.data > node ? current = current.left : current = current.right
  end
  count
end

def insert(val=0)
  current_root = self.root
  node = Node.new(val)
  return self.root = node if current_root == nil
   while current_root
    if current_root.data == val
      return 'Value is already in the tree!'
   elsif current_root.data > val
    if current_root.left.nil?
      return current_root.left = node
    else
      current_root = current_root.left
    end
  elsif current_root.data < val
    if current_root.right.nil?
      return current_root.right = node
    else
      current_root = current_root.right
    end
   end
  end
end


def delete(val)
  current = @root
  previous = @root
  direction = false
  inorder = nil

  while current
    # states that node is found
    if current.data == val
      #  if has one children
      if !current.left && !current.right
        direction == false ? previous.left = nil : previous.right = nil
        # if has two children 
      elsif (!current.left && current.right) || (current.left && !current.right)
        direction == false ? previous.left = current.left : previous.right = current.right
        # if has three children
      elsif current.left && current.right

        previous_of_current = current
        1.times{current = current.right}
     if !current.left.nil?
        inorder = current.left
        inorder.left = previous_of_current.left
        current.left = nil
        inorder.right = current.right
        direction == false ? previous.left = inorder : previous.right = inorder
      else
        inorder = previous_of_current.right
        inorder.left = previous_of_current.left
        direction == false ? previous.left = inorder : previous.right = inorder
      end
      
    end
      return
    else
      # traverses deeply if current node != val
      if current.data > val
        previous = current
        current.left.nil? ? current = current.right : current = current.left
        direction = false
      else
        previous = current
        current = current.right.nil? ? current = current.left : current = current.right
        direction = true
      end
    end   
end
end

def rebalance
  nodes_array = self.level_order
  self.build_tree(nodes_array,0,nodes_array.length-1)
end


def balanced
  nodes_array = self.level_order
  return true if nodes_array.length <= 1
  nodes_array.each do |node|
    node_left = node.left
    node_right = node.right
    count_left = 0
    count_right = 0

    while node_left
      node_left.left.nil? ? node_left = node_left.right : node_left = node_left.left
    count_left+=1
    end
    while node_right
      node_right.left.nil? ? node_right = node_right.right : node_right = node_right.left
      count_right+=1
    end
    return false if (count_left - count_right > 1) || (count_right - count_left > 1)
  end
  true
end

end

tree = Tree.new()
n = tree.arr.length
tree.build_tree(tree.arr,0,n-1)
# tree.level_order
# tree.preorder
# tree.postorder
# tree.inorder
# tree.insert(100)
# tree.insert(104)
# tree.insert(107)
# tree.insert(109)
# tree.insert(110)
# tree.insert(115)
# tree.balanced
# tree.rebalance
# tree.balanced
# tree.level_order
# tree.postorder
# tree.preorder
# tree.inorder