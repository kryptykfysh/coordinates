# coding: utf-8

require 'matrix'

module Coordinates::Cartesian
  # Representation of a point in three dimaensional space using, @x, @y, and
  # @z attributes.
  # @author Kryptykfysh
  class Coordinate
    # Defines the position on the X axis of two or three dimensional space.
    # @return [Float]
    attr_reader :x

    # Defines the position on the Y axis of two or three dimensional space.
    # @return [Float]
    attr_reader :y

    # Defines the position on the Z axis of a point in three dimensional space.
    # If the coordinate is in two dimensional space, returns nil.
    # Optional. Defaults to nil.
    # @return [Float] if a :z argument was passed on creation.
    # @return [nil] if no :z argument was passed on creation.
    attr_reader :z

    # Creates a new Coordinates::Cartesian::Coordinate object.
    # @param :x [Float, Fixnum, Integer]
    # @param :y [Float, Fixnum, Integer]
    # @param :z [Float, Fixnum, Integer, nil] Optional Z coordinate for three dimensions
    # @example Two Dimensional Coordinate
    #   Coordinate.new(x: 5, y: 7.3)
    #     => #<Coordinates::Cartesian::Coordinate:0xbab85780 @x=5.0, @y=7.3>
    # @example Three dimensional Coordinate
    #   Coordinate.new(x: 7.3, y: 5, z: -2.5)
    #     => #<Coordinates::Cartesian::Coordinate:0xbab85781 @x=7.3, @y=5.0, @z=-2.5>
    def initialize(x:, y:, z: nil)
      @x = x.is_a?(Float) ? x : x.to_f
      @y = y.is_a?(Float) ? y : y.to_f
      if z
        @z = z.is_a?(Float) ? z : z.to_f
      end
    end

    # Returns absolute distance to parameter other_coordinate
    # @param other_coordinate [Coordinates::Cartesian::Coordinate]
    # @return [Float]
    def range_to(other_coordinate)
      vector_to(other_coordinate).magnitude
    end

    # Returns a Vector object with the Coordinate values.
    # @return [Vector]
    def to_vector
      if two_dimensional?
        Vector[x, y]
      else
        Vector[x, y, z]
      end
    end

    # Returns true if the coordinate has only x and y positions.
    # @return [Boolean]
    def two_dimensional?
      z.nil?
    end

    # Returns a Vector, which when applied to #self, moves #self to
    # parameter other_coordinate.
    # If a two dimensional other-coordinate is passed to a three dimensional
    # instance, the parameter's @z will be treated as 0.
    # Likewise for a three dimension other_coordinate passed to a two
    # dimensional instance.
    # @param [Coordinates::Cartesian::Coordinate] other_coordinate
    # @return [Vector]
    def vector_to(other_coordinate)
      Vector[
        other_coordinate.x - x,
        other_coordinate.y - y,
        (other_coordinate.z || 0.0) - (self.z || 0.0)
      ]
    end
  end
end
