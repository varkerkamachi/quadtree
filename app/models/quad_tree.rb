class QuadTree

  #has_many :nodes

  attr_accessor :nodes, :node_data, :y1, :x1, :y2, :x2, :node_count
  # need to build initial tree bounding box ... 
  def initialize coords = {}
    return nil if coords == {}
    @x1 = coords[:x1] rescue nil
    @x2 = coords[:x2] rescue nil
    @y1 = coords[:y1] rescue nil
    @y2 = coords[:y2] rescue nil
    @node_count = 0
    @nodes = []
    @node_data = nil
  end

  # boolean - if needed - to check for presence of nodes within initial bounding box
  def has_nodes?
    @node_count > 0
  end

  # creates 4 nodes within initial bounding box
  def create_nodes
    if @nodes.blank?
      4.times do |x|
        coords = calculate_coords(x)
        @nodes << Node.new(coords)
        @node_count += 1
      end
    #else
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
    puts "coords: #{coords.inspect}"

    coords
  end

  # insert a data point into tree
  def add_data_point x,y
    @selected_node = nil
    # first we create nodes if none exist
    if @nodes.blank?
      create_nodes
    end
    puts "Nodes; #{@nodes.inspect}"
    # iterate through set of nodes checking for correct placement of data
    @nodes.each do |n|
      @selected_node = n if locate_correct_node_for_data(n,x,y)
    end
    return false if @selected_node.blank?
    puts "sel Nodes; #{@selected_node.inspect}"

    if @selected_node.present? && @selected_node.try(:is_full?)
      # create sub-nodes here .......
      @nodes = @selected_node.create_nodes
    else
      @selected_node.node_data = DataPoint.new(x,y)
      @selected_node.capacity += 1
    end

  end

  #calculates which node the data point belongs in
  def locate_correct_node_for_data node, datax, datay
    ((node.x1 <= datax && node.x2 >= datax) && (node.y1 <= datay && node.y2 >= datay))
  end

end