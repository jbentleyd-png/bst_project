# frozen_string_literal: true

require_relative '../lib/tree'


describe "build_tree" do
  it "returns the root node (midpoint)" do
    test = Tree.new([1, 2, 3])
    
    expect(test.build_tree([1, 2, 3])).to eq(2)
  end
end
