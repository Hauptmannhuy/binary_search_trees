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

# CHECK for the root if it has node in itself ?
# IF true add node in the root of the tree and RETURN

# check IF the insert value greater or lesser than root ?
# if bigger || lesser, check if the root.left or root.right != nil
# if data.left or data.right == nil then append new node and return
# else traverse deeply and follow same steps again

def delete(val)
  current = @root
  previous = @root
  direction = false

  while current
    if current.data == val
      if !current.left && !current.right
        direction == false ? previous.left = nil : previous.right = nil
        return
      end
      else
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
#  check if the current.data == val if false then follow next steps 1; else follow steps 2
#  1. then compare data and val, traverse deeply due to result and check again
#  2. check left and right child. if there is no child then follow step 2.1
#  2.1 set reference of previous node to current node

def traverse
  current = @root
  2.times do
  print current
    current = current.left
  end
end


end
tree = Tree.new()
n = tree.arr.length
# tree.build_tree(tree.arr,0,n-1)

tree.insert(1)
tree.insert(2)
tree.insert(3)
tree.insert(4)
