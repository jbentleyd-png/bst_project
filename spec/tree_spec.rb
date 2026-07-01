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

  xit "returns the root node (midpoint) on an unordered array with duplicates" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.tree.value).to eq(8)
  end

end
