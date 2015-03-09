# coding: utf-8

module Coordinates
  # Overrides Numeric and its subclasses to provide angle conversion
  # methods.
  module Angle
    refine Numeric do
      # Converts a value in degrees to radians
      # @return [Float] angle in radians
      def degrees_to_radians
        self * Math::PI / 180.0
      end

      # Converts a value in radians to degrees
      # @return [Float] angle in degrees
      def radians_to_degrees
        self * 180.0 / Math::PI
      end
    end
  end
end
