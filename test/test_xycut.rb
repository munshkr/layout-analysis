require "test/unit"
require "xycut"

class TestXYCutSlicer < Unit::Test::TestCase
  def setup
    @example_bbs = [
      BoundingBox.new(0, 0, 3, 5),
      BoundingBox.new(4, 3, 2, 2),
      BoundingBox.new(5, 1, 1, 1),
      BoundingBox.new(10, 0, 2, 7),
      BoundingBox.new(13, 2, 1, 3),
    ]
  end

  def test_new_with_default_options
    seg = XYCutSlicer.new(bbs)
    seg.process
    skip
  end

  def test_with_larger_min_gap_width
    seg = XYCutSlicer.new(bbs, :min_gap_width => 6)
    seg.process
    skip
  end
end
