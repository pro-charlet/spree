module Spree
  module Core
    module ImageDimensions
      def get_dimensions(style = :original)
        return dimensions[style] if dimensions.has_key? style

        filepath = attachment.to_file(style)
        dimensions[style] = Paperclip::Geometry.from_file(filepath)
      end

      def height(style = :original)
        get_dimensions(style) unless dimensions.has_key? style
        Integer(dimensions[style].height)
      end

      def width(style = :original)
        get_dimensions(style) unless dimensions.has_key? style
        Integer(dimensions[style].width)
      end
    end
  end
end
