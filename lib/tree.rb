require_relative 'node'

class Tree
  
  attr_accessor :root

  def build_tree(arr)
    root_position = (arr.length / 2).floor + ((arr.length % 2) - 1) # odd length: + 0; even length: - 1 (for a left-shift)
    root_value = arr[root_position]
    left_side = arr[0...root_position]
    right_side = arr[(root_position + 1)..]
    return Node.new(root_value) if right_side == []


    Node.new(root_value, build_tree(left_side), build_tree(right_side))
    
  end

  def initialize(arr)
    cleaned_arr = arr.sort.uniq
    @root = self.build_tree(cleaned_arr)  
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value)
    current = @root
    loop do
      return true if value == current.value 
      break if current.right.nil?
      current = value < current.value ? current.left : current.right
    end
    false
  end


end