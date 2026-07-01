# frozen_string_literal: true

require_relative '../lib/tree'


describe "build_tree" do
  it "returns the root node (midpoint: left-shifted) for an even number of elements" do
    test = Tree.new([1, 2, 3, 4])
    
    expect(test.tree.value).to eq(2)
  end

  it "returns the root node (midpoint) for an odd number of elements" do
    test = Tree.new([1, 2, 3, 4, 5, 6, 7])
    
    expect(test.tree.value).to eq(4)
  end


  it "returns the root node (midpoint) on an unordered array with duplicates" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.tree.value).to eq(8)
  end

  it "base case test 1" do
    test = Tree.new([1])
    
    expect(test.tree.value).to eq(1)
  end

  it "base case test 2" do
    test = Tree.new([1, 2])
    
    expect(test.tree.value).to eq(1)
  end

  it "links nodes together as expected" do 
    test = Tree.new([1, 2, 3, 4])
    return unless test.tree.value == 2
    return unless test.tree.left.value == 1
    return unless test.tree.right.value == 3
    three_node = test.tree.right
    test.pretty_print
    expect(three_node.right.value).to eq(4)
  end
end


describe "pretty_print" do
  it "seems to work" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.pretty_print).to eq(nil)
  end
end