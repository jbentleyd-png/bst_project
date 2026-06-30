require_relative 'node'

class Tree
  

  def build_tree(array)
    cleaned_arr = array.sort.uniq
    root_node = cleaned_arr[(cleaned_arr.length / 2).floor]
    root_node
  end

  def initialize(array)
    @tree = self.build_tree(array)  
  end


end