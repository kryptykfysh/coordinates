# coding:utf-8

require_relative './coordinates/version'
require_relative './coordinates/angle'
require_relative './coordinates/cartesian'
require_relative './coordinates/spherical'

# A namespace wrapper for all the Coordinates sub modules.
# @author Kryptykfysh
module Coordinates
  # Provides access to angle conversion methods on Numeric types.
  # @see Coordinates::Angle
  using Angle
end
