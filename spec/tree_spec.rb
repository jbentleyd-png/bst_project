# frozen_string_lxiteral: true

require_relative '../lib/tree'


describe "build_tree" do
  xit "returns the root node (midpoint: left-shifted) for an even number of elements" do
    test = Tree.new([1, 2, 3, 4])
    
    expect(test.root.value).to eq(2)
  end

  xit "returns the root node (midpoint) for an odd number of elements" do
    test = Tree.new([1, 2, 3, 4, 5, 6, 7])
    
    expect(test.root.value).to eq(4)
  end


  xit "returns the root node (midpoint) on an unordered array wxith duplicates" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.root.value).to eq(8)
  end

  xit "base case test 1" do
    test = Tree.new([1])
    
    expect(test.root.value).to eq(1)
  end

  xit "base case test 2" do
    test = Tree.new([1, 2])
    test.pretty_print
    expect(test.root.value).to eq(1)
  end

  xit "links nodes together as expected" do 
    test = Tree.new([1, 2, 3, 4])
    return unless test.root.value == 2
    return unless test.root.left.value == 1
    return unless test.root.right.value == 3
    three_node = test.root.right
    test.pretty_print
    expect(three_node.right.value).to eq(4)
  end

  xit "intermediate nodes don't generate an empty node when they only have one child" do
    test = Tree.new([1, 2, 3, 4])
    
    expect(test.root.right.left).to eq(nil)
  end

end


describe "pretty_print" do
  xit "seems to work" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.pretty_print).to eq(nil)
  end

  xit "confirms my modeling" do
    input = [1, 3, 6, 7, 12, 15]
    test = Tree.new(input)
    expect(test.pretty_print).to eq(nil)
  end
end

describe "include?" do
  
  xit "works when the root value of the tree matches" do
    test = Tree.new([74])
    expect(test.include?(74)).to eq(true)
  end

  xit "returns false when the root value of the tree doesn't match" do
    test = Tree.new([64])
    expect(test.include?(74)).to eq(false)
  end

  xit "returns true two layers deep" do 
    test = Tree.new([1, 2, 3, 4])
    expect(test.include?(4)).to eq(true)
  end

  xit "returns true three layers deep" do 
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.include?(6345)).to eq(true)
  end

  xit "returns false when there is no root" do
    test = Tree.new([])
    expect(test.include?(6345)).to eq(false)
  end


end 

describe "insert" do
  
  xit "returns nil when the root value of the tree matches" do
    test = Tree.new([74])
    expect(test.insert(74)).to eq(nil)
  end

  xit "adds a Node" do
    test = Tree.new([64])
    test.insert(74)
    expect(test.include?(74)).to eq(true)
  end

  xit "adds a node to the correct side" do 
    test = Tree.new([64])
    test.insert(74)
    expect(test.root.right.value).to eq(74)
  end

  xit "links nodes together as expected" do 
    test = Tree.new([1, 2, 3, 5])
    test.insert(4)
    test.pretty_print
    expect(test.root.right.right.left.value).to eq(4)
  end
end

describe "delete" do
  xit "deletes nothing if the value is not found" do
    test = Tree.new([74])
    expect(test.delete(4)).to eq(nil)
  end

  xit "deletes a leaf node" do
    test = Tree.new([1, 2, 3, 4])
    test.delete(4)
    expect(test.include?(4)).to eq(false)
  end

  xit "deletes a leaf node that is also the root node" do
    test = Tree.new([4])
    test.delete(4)
    expect(test.root).to eq(nil)
  end

  xit "deletes a node wxith one child" do
    test = Tree.new([1, 2, 3, 4])
    test.pretty_print
    test.delete(3)
    test.pretty_print
    expect(test.root.right.value).to eq(4)
  end

  xit "...which is also the root node" do
    test = Tree.new([1, 2])
    test.pretty_print
    test.delete(1)
    test.pretty_print
    expect(test.root.value).to eq(2)
  end

  it "deletes a node on the RIGHT wxith two children" do
    test = Tree.new([1, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(12)
    test.pretty_print
    expect(test.root.right.value).to eq(7)
  end

  it "deletes a node on the LEFT wxith two children" do
    test = Tree.new([1, 2, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(2)
    test.pretty_print
    expect(test.root.left.value).to eq(1)
  end

  it "...which is also the root node" do
    test = Tree.new([1, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(6)
    test.pretty_print
    expect(test.root.value).to eq(7)
  end
end
