require_relative 'node'

class Tree
  
  attr_accessor :tree

  def build_tree(arr)
    root_position = (arr.length / 2).floor + ((arr.length % 2) - 1) # odd length: + 0; even length: - 1 (for a left-shift)
    p " root_pos: #{root_position}" 
    root_value = arr[root_position]
    p root_value
    left_side = arr[0...root_position]
    p left_side
    right_side = arr[(root_position + 1)..]
    p right_side
    return Node.new(root_value) if right_side == []


    Node.new(root_value, build_tree(left_side), build_tree(right_side))
    
  end

  def initialize(arr)
    cleaned_arr = arr.sort.uniq
    p "cleaned arr length: #{cleaned_arr.length}"
    @tree = self.build_tree(cleaned_arr)  
  end


end