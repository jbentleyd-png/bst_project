require_relative 'node'

class Tree
  
  attr_accessor :tree

  def build_tree(arr)
    root_value = arr[(arr.length / 2).floor]
    root_node = Node.new(root_value)
    root_node
  end

  def initialize(arr)
    cleaned_arr = arr.sort.uniq
    @tree = self.build_tree(cleaned_arr)  
  end


end