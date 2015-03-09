# coding: utf-8

require 'spec_helper'

module Coordinates
  module Cartesian
    RSpec.describe Coordinate do
      let(:coordinate_hash) { { x: 0, y: 0, z: 1 } }
      let(:coordinate) { Coordinate.new(coordinate_hash) }
      subject { coordinate }

      describe 'attributes' do
        specify { expect(subject).to respond_to :x }
        specify { expect(subject).to respond_to :y }
        specify { expect(subject).to respond_to :z }

        describe '@x' do
          specify { expect(coordinate.x).to be_a_kind_of Float }
        end

        describe '@y' do
          specify { expect(coordinate.y).to be_a_kind_of Float }
        end

        describe '@z' do
          context 'when no :z supplied to ::new' do
            let(:no_z_hash) { { x: 0, y:0 } }
            let(:no_z_coord) { Coordinate.new(no_z_hash) }

            it 'should be nil' do
              expect(no_z_coord.z).to be_nil
            end
          end

          context 'when a :z value is supplied to ::new' do
            let(:coord_hash) { { x: 0, y: 0, z: 0 } }
            let(:coord) { Coordinate.new(coord_hash) }

            specify { expect(coord.z).to be_a_kind_of(Float) }
          end
        end
      end

      describe 'instance methods' do
        specify { expect(coordinate).to respond_to :range_to          }
        specify { expect(coordinate).to respond_to :to_vector         }
        specify { expect(coordinate).to respond_to :two_dimensional?  }
        specify { expect(coordinate).to respond_to :vector_to         }

        describe '#range_to' do
          let(:other_coord) { Coordinate.new(x: 42, y:69, z: -5) }

          context 'without a Coordinate argument' do
            specify { expect{ coordinate.range_to }.to raise_error(ArgumentError) }
          end

          context 'with a valid other_coordinate argument' do
            let(:other) { Coordinates::Cartesian::Coordinate.new(x: 1, y: 2, z: 2) }

            it 'returns the absolute distance between the coordinates' do
              expect(coordinate.range_to(other))
                .to eq(2.449489742783178)
            end
          end
        end

        describe '#to_vector' do
          specify { expect(coordinate.to_vector).to be_a Vector }

          context 'on a two dimensional coordinate' do
            let(:no_z_hash) { { x: 0, y:0 } }
            let(:two_d) { Coordinate.new(no_z_hash) }

            it 'should return a two dimensional vector' do
              expect(two_d.to_vector.size).to eq(2)
            end

            it 'should have values [:x, :y]' do
              expect(two_d.to_vector).to eq(Vector[two_d.x, two_d.y])
            end
          end

          context 'on a three dimensional coordinate' do
            it 'should return a three dimensional vector' do
              expect(coordinate.to_vector.size).to eq(3)
            end

            it 'should have value [:x, :y, :z]' do
              expect(coordinate.to_vector).to eq(Vector[coordinate.x, coordinate.y, coordinate.z])
            end
          end
        end

        describe '#vector_to' do
          context 'with no argument supplied' do
            specify { expect{ coordinate.vector_to }.to raise_error(ArgumentError) }
          end

          context 'with a two dimensional coordinate argument on a three dimensional coordinate' do
            let(:target) { Coordinates::Cartesian::Coordinate.new(x: 42, y: 69) }

            it 'treats the parameter\'s @z as 0' do
              expect(coordinate.vector_to(target))
                .to eq(Vector[
                              target.x - coordinate.x,
                              target.y - coordinate.y,
                              0.00 - coordinate.z
                ])
            end
          end

          context 'with a three dimensional coordinate argument on a two dimensional coordinate' do
            let(:target) { Coordinates::Cartesian::Coordinate.new(x: 42, y: 69, z: 169) }
            before { coordinate.instance_variable_set('@z', nil) }

            it 'treats the parameter\'s @z as 0' do
              expect(coordinate.vector_to(target))
                .to eq(Vector[
                              target.x - coordinate.x,
                              target.y - coordinate.y,
                              target.z - 0.0
                ])
            end
          end
        end

        describe '#two_dimensional?' do
          context 'coordinate has a @z attribute' do
            specify { expect(coordinate.two_dimensional?).to eq(false) }
          end
        end
      end
    end

    describe 'class methods' do
      describe '::new' do
        context 'without an :x argument' do
          let(:no_x_hash) { { y: 0, z: 0 } }

          it 'should throw an ArgumentError' do
            expect{ Coordinate.new(no_x_hash) }.to raise_error(ArgumentError)
          end
        end

        context 'without a :y argument' do
          let(:no_y_hash) { { x: 0, z: 0 } }

          it 'should throw an ArgumentError' do
            expect{ Coordinate.new(no_y_hash) }.to raise_error(ArgumentError)
          end
        end

        context 'without a :z argument' do
          let(:no_z_hash) { { x: 0, y:0 } }

          it 'should not raise an error' do
            expect{ Coordinate.new(no_z_hash) }.to_not raise_error
          end

          it 'should set @z to nil' do
            c = Coordinate.new(no_z_hash)
            expect(c.z).to be_nil
          end
        end
      end
    end
  end
end
