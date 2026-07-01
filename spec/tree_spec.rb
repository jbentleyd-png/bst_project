# frozen_string_literal: true

require_relative '../lib/tree'


describe "build_tree" do
  it "returns the root node (midpoint)" do
    test = Tree.new([1, 2, 3])
    
    expect(test.tree.value).to eq(2)
  end

  it "returns the root node (midpoint) on an unordered array with duplicates" do
    input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
    test = Tree.new(input)
    expect(test.tree.value).to eq(8)
  end

end
