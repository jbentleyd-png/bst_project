# frozen_string_literal: true

require_relative '../lib/tree'


describe "build_tree" do
  it "returns the root node (midpoint: left-shifted) for an even number of elements" do
    test = Tree.new([1, 2, 3, 4])
    
    expect(test.root.value).to eq(2)
  end

  it "returns the root node (midpoint) for an odd number of elements" do
    test = Tree.new([1, 2, 3, 4, 5, 6, 7])
    
    expect(test.root.value).to eq(4)
  end


  it "returns the root node (midpoint) on an unordered array with duplicates" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.root.value).to eq(8)
  end

  it "base case test 1" do
    test = Tree.new([1])
    
    expect(test.root.value).to eq(1)
  end

  it "base case test 2" do
    test = Tree.new([1, 2])
    test.pretty_print
    expect(test.root.value).to eq(1)
  end

  it "links nodes together as expected" do 
    test = Tree.new([1, 2, 3, 4])
    return unless test.root.value == 2
    return unless test.root.left.value == 1
    return unless test.root.right.value == 3
    three_node = test.root.right
    test.pretty_print
    expect(three_node.right.value).to eq(4)
  end

  it "intermediate nodes don't generate an empty node when they only have one child" do
    test = Tree.new([1, 2, 3, 4])
    
    expect(test.root.right.left).to eq(nil)
  end

end


describe "pretty_print" do
  it "seems to work" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.pretty_print).to eq(nil)
  end

  it "confirms my modeling" do
    input = [1, 3, 6, 7, 12, 15]
    test = Tree.new(input)
    expect(test.pretty_print).to eq(nil)
  end
end

describe "include?" do
  
  it "works when the root value of the tree matches" do
    test = Tree.new([74])
    expect(test.include?(74)).to eq(true)
  end

  it "returns false when the root value of the tree doesn't match" do
    test = Tree.new([64])
    expect(test.include?(74)).to eq(false)
  end

  it "returns true two layers deep" do 
    test = Tree.new([1, 2, 3, 4])
    expect(test.include?(4)).to eq(true)
  end

  it "returns true three layers deep" do 
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.include?(6345)).to eq(true)
  end

  it "returns false when there is no root" do
    test = Tree.new([])
    expect(test.include?(6345)).to eq(false)
  end


end 

describe "insert" do
  
  it "returns nil when the root value of the tree matches" do
    test = Tree.new([74])
    expect(test.insert(74)).to eq(nil)
  end

  it "adds a Node" do
    test = Tree.new([64])
    test.insert(74)
    expect(test.include?(74)).to eq(true)
  end

  it "adds a node to the correct side" do 
    test = Tree.new([64])
    test.insert(74)
    expect(test.root.right.value).to eq(74)
  end

  it "links nodes together as expected" do 
    test = Tree.new([1, 2, 3, 5])
    test.insert(4)
    test.pretty_print
    expect(test.root.right.right.left.value).to eq(4)
  end
end

describe "delete" do
  it "deletes nothing if the value is not found" do
    test = Tree.new([74])
    expect(test.delete(4)).to eq(nil)
  end

  it "deletes a leaf node" do
    test = Tree.new([1, 2, 3, 4])
    test.delete(4)
    expect(test.include?(4)).to eq(false)
  end

  it "deletes a leaf node that is also the root node" do
    test = Tree.new([4])
    test.delete(4)
    expect(test.root).to eq(nil)
  end

  it "deletes a node with one child" do
    test = Tree.new([1, 2, 3, 4])
    test.pretty_print
    test.delete(3)
    test.pretty_print
    expect(test.root.right.value).to eq(4)
  end

  it "...which is also the root node" do
    test = Tree.new([1, 2])
    test.pretty_print
    test.delete(1)
    test.pretty_print
    expect(test.root.value).to eq(2)
  end

  it "deletes a node on the RIGHT with two children" do
    test = Tree.new([1, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(12)
    test.pretty_print
    expect(test.root.right.value).to eq(15)
  end

  it "deletes a node on the LEFT with two children" do
    test = Tree.new([1, 2, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(2)
    test.pretty_print
    expect(test.root.left.value).to eq(3)
  end

  it "...which is also the root node" do
    test = Tree.new([1, 3, 6, 7, 12, 15])
    test.pretty_print
    test.delete(6)
    test.pretty_print
    expect(test.root.value).to eq(7)
  end

  describe "level_order" do
    it "returns an enum when no block is given" do
      test = Tree.new([1, 3, 6, 7, 12, 15])
      expect(test.level_order(6)).to be_an(Enumerator)
    end
  end
end
