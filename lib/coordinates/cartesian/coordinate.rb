# coding: utf-8

require 'matrix'

module Coordinates::Cartesian
  class Coordinate
    # Defines the position on the X axis of two or three dimensional space.
    # @return [Float]
    attr_reader :x

    # Defines the position on the Y axis of two or three dimensional space.
    # @return [Float]
    attr_reader :y

    # Defines the position on the Z axis of a point in three dimensional space.
    #   If the coordinate is in two dimensional space, returns nil.
    # @return [Float, nil]
    attr_reader :z

    # Creates a new Coordinates::Cartesian::Coordinate object.
    # @param :x [Float, Fixnum, Integer]
    # @param :y [Float, Fixnum, Integer]
    # @param :z [Float, Fixnum, Integer, nil] Optional Z coordinate for three dimensions
    def initialize(x:, y:, z: nil)
      @x = x.is_a?(Float) ? x : x.to_f
      @y = y.is_a?(Float) ? y : y.to_f
      if z
        @z = z.is_a?(Float) ? z : z.to_f
      end
    end

    def range_to
    end

    def to_vector
      Vector[1, 1]
    end

    # Returns true if the coordinate has only x and y positions.
    # @return [Boolean]
    def two_dimensional?
      z.nil?
    end
  end
end
