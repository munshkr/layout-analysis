require "slicer"

class XYCutSlicer < Slicer
  attr_accessor :min_width_gap

  def initialize(bounding_boxes, opts={})
    super(bounding_boxes, opts)

    opts = {
      :min_width_gap => 1,
    }.merge(opts)

    @min_width_gap = opts[:min_width_gap]
  end

  def process
    pp_hor, pp_ver = build_projection_profiles(@bounding_boxes)
    max_gap_hor = get_widest_gap(pp_hor)
    max_gap_ver = get_widest_gap(pp_ver)
    [pp_hor, pp_ver, max_gap_hor, max_gap_ver]
  end

private
  def build_projection_profiles(bounding_boxes)
    max_width_bb  = bounding_boxes.max { |a, b| (a.x + a.width)  <=> (b.x + b.width)  }
    max_height_bb = bounding_boxes.max { |a, b| (a.y + a.height) <=> (b.y + b.height) }
    max_width  = max_width_bb.x + max_width_bb.width
    max_height = max_height_bb.y + max_height_bb.height

    pp_horizontal = [0] * max_height
    pp_vertical   = [0] * max_width

    bounding_boxes.each do |bb|
      pp_horizontal.fill(bb.y, bb.height) { |i| pp_horizontal[i] += 1 }
      pp_vertical.fill(bb.x, bb.width)    { |i| pp_vertical[i]   += 1 }
    end

    [pp_horizontal, pp_vertical]
  end

  def get_widest_gap(projection_profile, min_gap_width=1)
    start = nil
    length = nil
    max_gap = nil

    projection_profile.each.with_index do |v, i|
      if start.nil? && v == 0
        start = i
      elsif start && v > 0
        length = i - start
        if length >= min_gap_width and (max_gap.nil? or (max_gap[1] < length))
          max_gap = [start, length]
        end
        start = nil
      end
    end

    max_gap
  end
end
