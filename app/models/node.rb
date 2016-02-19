class Node
  #belongs_to :quad_tree

  attr_accessor :nodes, :node_data, :y1, :x1, :y2, :x2, :capacity, :node_count, :node_data

  def initialize coords={}
    @x1 = coords[:x1] rescue nil
    @x2 = coords[:x2] rescue nil
    @y1 = coords[:y1] rescue nil
    @y2 = coords[:y2] rescue nil
    @capacity = 0
    @node_count = 0
    @nodes = [] if @nodes.blank?
    @node_data = nil
    puts "self? #{self.inspect} ............"
  end

  # boolean - if needed - to check for presence of nodes within each node
  def has_nodes?
    @node_count > 0
  end

  def create_nodes
    4.times do |n|
      coords = calculate_coords(n)
      @nodes << Node.new(coords)
      @node_count += 1
    end
    @nodes
  end


  # calculate the xy coords based on integer passed in from iteration loop. should be 0-3
  def calculate_coords int
    int = int.present? ? int : 0
    coords = {x1:0,x2:0,y1:0,y2:0}

    case int
      # southwest quadrant
    when 0
      coords[:x1] = 0
      coords[:y1] = 0
      coords[:x2] = @x2/2
      coords[:y2] = @y2/2
    # southeast quad
    when 1
      coords[:x1] = @x2/2
      coords[:y1] = 0
      coords[:x2] = @x2
      coords[:y2] = @y2/2
    # northwest quad
    when 2
      coords[:x1] = 0
      coords[:y1] = @y2/2
      coords[:x2] = @x2/2
      coords[:y2] = @y2
    # northeast quad
    else
      coords[:x1] = @x2/2
      coords[:y1] = @y2/2
      coords[:x2] = @x2
      coords[:y2] = @y2
    end

    coords
  end

  # boolean to check if we have a data point in that node
  def is_full?
    @capacity == 1
  end


end