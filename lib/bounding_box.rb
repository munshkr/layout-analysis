class BoundingBox
  attr_reader :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x, @y, @width, @height = [x, y, width, height]
  end
end
