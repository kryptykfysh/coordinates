# coding: utf-8

module Coordinates
  module Spherical
    # Representation of a point in three dimensional space using
    # @radial_distance, @polar_angle and @azimuth_angle.
    # By default angles are measured in radians.
    # Unless otherwise stated, the spherical coordinates are assumed to use
    # mathematic notation, rather than physics notation. That is,
    # @azimuth_angle is the signed angle between the line segment and z axis,
    # and @polar_angle is the angle on the reference plane from x axis.
    # @author Kryptykfysh
    class Coordinate
      # @return [Float] Distance from origin point.
      attr_reader :radial_distance

      # @return [Float] Angle, in radians, on the reference place, from the
      #   x-axis. From 0.0 to 2 * Math::PI radians.
      attr_reader :polar_angle

      # @return [Float] Angle, in radians, from the z-axis. From 0 to
      #   Math::PI radians.
      attr_reader :azimuth_angle

      # Creates a new spherical Coordinate.
      # @param radial_distance [Float, Fixnum, Integer] the absolute distance
      #   from the origin point
      # @param polar_angle [Float, Fixnum, Integer] The angle, in radians, on
      #   the reference plane from the x-axis. Range: 0.. 2 * PI rad Range -PI..PI rad.
      # @param azimuth_angle [Float, Fixnum, Integer] The angle, in radians,
      #   from the z-axis. Range 0..PI rad.
      def initialize (
          radial_distance:,
          polar_angle:,
          azimuth_angle: Math::PI / 2
        )
        @radial_distance  = radial_distance.to_f
        @polar_angle      = polar_angle.to_f
        @azimuth_angle    = azimuth_angle.to_f
      end

      # Return a new Cartesian::Coordinate object representing the same point.
      # @return [Coordinates::Cartesian::Coordinate]
      def to_cartesian
        x = radial_distance * Math.sin(azimuth_angle) * Math.cos(polar_angle)
        y = radial_distance * Math.sin(azimuth_angle) * Math.sin(polar_angle)
        z = radial_distance * Math.cos(azimuth_angle)
        Coordinates::Cartesian::Coordinate.new(x: x, y: y, z: z)
      end

      # Calculates a polar vector, which when applied to #self, maps to
      # the other_coordinate parameter.
      # @return [Coordinates::Spherical::Coordinate]
      def vector_to(other_coordinate)
      end
    end
  end
end
