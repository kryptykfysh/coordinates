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
        specify { expect(coordinate).to respond_to :==                }
        specify { expect(coordinate).to respond_to :apply_vector      }
        specify { expect(coordinate).to respond_to :apply_vector!     }
        specify { expect(coordinate).to respond_to :range_to          }
        specify { expect(coordinate).to respond_to :to_vector         }
        specify { expect(coordinate).to respond_to :two_dimensional?  }
        specify { expect(coordinate).to respond_to :vector_to         }

        describe '#==' do
          context 'when no argument is supplied' do
            specify { expect{ coordinate.== }.to raise_error(ArgumentError) }
          end

          context 'when a valid other Object is supplied' do
            context 'with @x, @y, and @z values equal to coordinate' do
              let(:thing) do
                Thing = Struct.new(:x, :y, :z)
                Thing.new(coordinate.x, coordinate.y, coordinate.z)
              end

              specify { expect(coordinate == thing).to eq(true) }
            end

            context 'when axis variables are not present on other argument Object' do
              let(:thing) { Object.new }

              specify { expect(coordinate == thing).to eq(false) }
            end
          end
        end

        describe '#apply_vector' do
          context 'without a Vector argument' do
            specify { expect{ coordinate.apply_vector }.to raise_error(ArgumentError) }
          end

          context 'with a valid Vector argument' do
            let(:vector) { Vector[1, 2.5, -3] }
            let(:new_coord) { coordinate.apply_vector(vector) }

            it 'should return a new Coordinate' do
              expect(coordinate.apply_vector(vector)).to be_an_instance_of(Coordinate)
            end

            it 'returns the new Coordinate with the @x, @y and @z attributes updated' do
              expect(new_coord.x).to eq(coordinate.x + vector[0])
              expect(new_coord.y).to eq(coordinate.y + vector[1])
              expect(new_coord.z).to eq(coordinate.z + vector[2])
            end
          end
        end

        describe '#apply_vector!' do
          context 'without a vector argument' do
            specify { expect{ coordinate.apply_vector! }.to raise_error(ArgumentError) }
          end

          context 'with a valid vector argument' do
            let(:vector) { Vector[1, 2.5, -7] }

            it 'returns the original Coordinate object' do
              expect(coordinate.apply_vector!(vector)).to be(coordinate)
            end

            context 'for a three dimensional coordinate' do
              [:x, :y, :z].each_with_index do |axis, index|
                it "updates the Coordinate's @#{axis}" do
                  expect{ coordinate.apply_vector!(vector) }
                    .to change{ coordinate.send(axis) }
                    .from(coordinate.send(axis))
                    .to(coordinate.send(axis) + vector[index])
                end
              end
            end

            context 'for a two dimensional coordinate' do
              let(:two_d) { Coordinate.new(x: 0, y: 1) }
              let(:vector) { Vector[-0.5, 3.75] }

              [:x, :y].each_with_index do |axis, index|
                it "updates the Coordinate's @#{axis}" do
                  expect{ two_d.apply_vector!(vector) }
                    .to change{ two_d.send(axis) }
                    .from(two_d.send(axis))
                    .to(two_d.send(axis) + vector[index])
                end

                it 'does not update the @z axis' do
                  expect{ two_d.apply_vector!(vector) }
                    .to_not change{ two_d.z }
                    .from(nil)
                end
              end
            end
          end
        end

        describe '#range_to' do
          let(:other_coord) { Coordinate.new(x: 42, y:69, z: -5) }

          context 'without a Coordinate argument' do
            specify { expect{ coordinate.range_to }.to raise_error(ArgumentError) }
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

        describe '#two_dimensional?' do
          context 'coordinate has a @z attribute' do
            specify { expect(coordinate.two_dimensional?).to eq(false) }
          end
        end

        describe '#vector_to' do
          context 'without an other_coordinate argument' do
            specify { expect{ coordinate.vector_to }.to raise_error(ArgumentError) }
          end

          context 'with a valid other_coordinate argument' do
            let(:other) { Coordinate.new(x: 42, y: 69, z: -75.423) }

            it 'should return a Vector' do
              expect(coordinate.vector_to(other)).to be_an_instance_of Vector
            end

            it 'should return a Vector that maps self to the Coordinate argument' do
              expect(coordinate.apply_vector(coordinate.vector_to(other)))
                .to eq(other)
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
end
