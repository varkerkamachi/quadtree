require 'rails_helper'

RSpec.describe QuadTree, type: :model do
  describe "instantiation" do
    it "is unsuccessful without args passed" do
      q = QuadTree.new
      expect(q.capacity).to eq nil
    end
    it "of the capacity is successful with a capacity value passed" do
      q = QuadTree.new({}, 2)
      expect(q.capacity).to eq 2
    end
    it "of the coordinates is successful with a valid coords object passed" do
      q = QuadTree.new({x1: 0, y1: 0, x2: 20, y2: 100}, 2)
      expect(q.x2).to eq 20
    end
  end
end