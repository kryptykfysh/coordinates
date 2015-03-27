# coding: utf-8

require 'spec_helper'

module Coordinates::Spherical
  RSpec.describe Coordinate do
    let(:point) do
      Coordinates::Spherical::Coordinate.new(
        radial_distance:  1.0,
        polar_angle:      Math::PI / 4,
        azimuth_angle:    Math::PI / 2
      )
    end
    subject { point }

    describe 'attributes' do
      specify { expect(point).to respond_to :radial_distance  }
      specify { expect(point).to respond_to :polar_angle      }
      specify { expect(point).to respond_to :azimuth_angle    }
    end

    describe 'instance methods' do
      specify { expect(point).to respond_to :to_cartesian     }
      specify { expect(point).to respond_to :vector_to        }

      describe '#to_cartesian' do
        it 'returns the spherical coordinate as a cartesian coordinate' do
          expect(point.to_cartesian.x).to eq(0.7071067811865476)
          expect(point.to_cartesian.y).to eq(0.7071067811865475)
          expect(point.to_cartesian.z).to eq(6.123233995736766e-17)
        end
      end

      describe '#vector_to' do
        context 'with no other_coordinate argument' do
          it 'raises an ArgumentError' do
            expect{point.vector_to}.to raise_error(ArgumentError)
          end
        end

        context 'with a valid other_coordinate argument' do
          let(:other_point) do
            Coordinates::Spherical::Coordinate.new(
              radial_distance:  2.0,
              polar_angle:      Math::PI / 3,
              azimuth_angle:    Math::PI / 1.5
            )
          end
        end
      end
    end

    describe 'class methods' do
      describe '::new' do
        context 'with no :azimuth_angle argument' do
          let(:two_d_point) do
            Coordinates::Spherical::Coordinate.new(
              radial_distance:  1.0,
              polar_angle:      Math::PI / 2
            )
          end

          it 'should create a point with @azimuth_angle PI / 2' do
            expect(two_d_point.azimuth_angle).to eq(Math::PI / 2)
          end
        end
      end
    end
  end
end
