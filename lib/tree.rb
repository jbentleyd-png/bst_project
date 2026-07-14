require_relative 'node'

class Tree
  
  attr_accessor :root

  def build_tree(arr)
    return nil if arr == [] # prevents empty left nodes from being printed recursively.
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
    return false if @root == nil
    current = @root
    loop do
      return true if value == current.value 
      break if current.right.nil?
      current = value < current.value ? current.left : current.right
    end
    false
  end

  def insert(value) 
    current = @root
    loop do
      return nil if value == current.value 
      break if current.right.nil? # reached a terminal node 
      current = value < current.value ? current.left : current.right # traverse
    end
    relationship = value < current.value ? "left" : "right"
    current.public_send("#{relationship}=", Node.new(value)) # NOT:     current.public_send(relationship) = Node.new(value)
    false
  end
  
  def delete(value)
    current = @root
    previous = nil
    
    loop do # traverse for deletion node
      break if value == current.value # FOUND IT
      return if current.right.nil? # not in tree
      previous = current
      current = value < current.value ? current.left : current.right
    end

    # below is for clarity. We till traverse again if there are two children below the deletion node.
    deletion_node = current
    del_node_parent = previous
    unless deletion_node == @root # guard clause for 2 children
      del_parent_relationship = value < del_node_parent.value ? "left" : "right"
    end


    # NO children:
    if deletion_node.left.nil? && deletion_node.right.nil?
      if del_node_parent.nil? # root edge case
        @root = nil
        return
      end
      del_node_parent.public_send("#{del_parent_relationship}=", nil)
    end

    # one child policy:
    if (deletion_node.left.nil? && !deletion_node.right.nil?) || (!deletion_node.left.nil? && deletion_node.right.nil?)
      child_relationship = deletion_node.left ? "left" : "right"

      if del_node_parent.nil? # root edge case
        @root = deletion_node.public_send(child_relationship)
        return
      end

      del_node_parent.public_send("#{del_parent_relationship}=", deletion_node.public_send(child_relationship))
      
    end

    # TWO child policy:
    if !deletion_node.left.nil? && !deletion_node.right.nil?
      # find the smallest big guy aka "inorder successor":
      previous = current
      current = current.right

      loop do 
        break if current.left.nil?
        previous = current
        current = current.left
      end

      # switch deleted node's value with that of its successor:
      deletion_node.value = current.value
      # remove reference to the inorder successor from its parent:
      relationship = current.value < previous.value ? "left" : "right"
      previous.public_send("#{relationship}=", nil) # "current as an extra pointer is critical here"

    end

  end
  
  def print_level_order
    queue =[@root]
    nodes = 0

    loop do 
      current = queue.shift
      break if current.nil?
      print "#{current.value}, "
      queue.push current.left unless current.left == nil
      queue.push current.right unless current.right == nil
      nodes += 1
    end
    p "nodes = #{nodes}"
    nodes

  end


  # no () style argument needed, blocks are passed differently.
  def level_order # essentially ".each" for the tree, in the order we want
    
    # return an enumerable if no block is given
    return to_enum(:level_order) unless block_given?
    # traverse the tree in level order & yield each value to the block
    queue =[@root]

    loop do 
      current = queue.shift
      break if current.nil?
      yield(current.value)
      queue.push current.left unless current.left.nil?
      queue.push current.right unless current.right.nil?
    end

    self # enables method chaining even after a block

  end

  def preorder(current = @root, &block)
    return to_enum(:preorder) unless block_given?
    
    return self if current.nil? # do self here just in case a block is passed but it's an empty tree
    
    yield(current.value)
    preorder(current.left, &block) # pass the block to the recursive call, too
    preorder(current.right, &block)

    self
  end

  def inorder(current = @root, &block)
    return to_enum(:inorder) unless block_given?
    return self if current.nil?

    inorder(current.left, &block)
    yield(current.value) 
    inorder(current.right, &block)

    self
  end

  def postorder(current = @root, &block)
    return to_enum(:postorder) unless block_given?
    return self if current.nil?
    
    postorder(current.left, &block)
    postorder(current.right, &block)
    yield(current.value) 

    self # yielding...nothing?
  end



end