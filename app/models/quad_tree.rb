class QuadTree

  attr_accessor :node, :node_data, :y1, :x1, :y2, :x2, :capacity

  # need to build initial tree bounding box ... 
  def initialize coords = {}, capacity=0
    return nil if coords == {} && capacity == 0
    @capacity = capacity
    @x1 = coords[:x1] rescue nil
    @x2 = coords[:x2] rescue nil
    @y1 = coords[:y1] rescue nil
    @y2 = coords[:y2] rescue nil
  end
end