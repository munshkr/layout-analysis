##
# Abstract class for page segmentation algorithms
#
class Slicer
  attr_accessor :bounding_boxes

  def initialize(bounding_boxes, opts={})
    @bounding_boxes = bounding_boxes
  end

  def process
    raise NotImplementedError
  end
end
