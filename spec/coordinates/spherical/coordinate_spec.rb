# coding: utf-8

require 'spec_helper'

module Coordinates::Spherical
  RSpec.describe Coordinate do
    let(:point) do
      Coordinates::Spherical::Coordinate.new(
        radial_distance:  1.0,
        polar_angle:      Math::PI / 2,
        azimuth_angle:    Math::PI / 4
      )
    end
    subject { point }

    describe 'attributes' do
      specify { expect(point).to respond_to :radial_distance  }
      specify { expect(point).to respond_to :polar_angle      }
      specify { expect(point).to respond_to :azimuth_angle    }
    end

    describe 'class methods' do
      describe '::new' do
      end
    end
  end
end
