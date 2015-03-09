# coding: utf-8

require 'spec_helper'

module Coordinates
  using Angle
  RSpec.describe Angle do
    describe 'Numeric methods' do
      describe '#degrees to radians' do
        it 'returns the degree value in float number of radians' do
          expect(45.degrees_to_radians).to eq(Math::PI / 4)
        end
      end

      describe '#radians_to_degrees' do
        it 'returns the radian value in float number of degrees' do
          expect((Math::PI / 4).radians_to_degrees).to eq(45.0)
        end
      end
    end
  end
end
