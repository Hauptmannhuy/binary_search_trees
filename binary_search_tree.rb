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
    return root
end




end
build_tree = Tree.new()
n = build_tree.arr.length
tree = build_tree.build_tree(build_tree.arr,0,n-1)