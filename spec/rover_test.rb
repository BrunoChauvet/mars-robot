require_relative 'spec_helper'
require_relative '../lib/rover'

describe Rover do
  describe 'creation' do
    subject { Rover.new(1, 2, Direction::North) }

    it 'initialises attributes' do
      expect(subject.x).to eql(1)
      expect(subject.y).to eql(2)
      expect(subject.direction).to eql(Direction::North)
    end
  end

  describe 'parse_commands' do
    let(:x) { 0 }
    let(:y) { 0 }
    let(:direction) { Direction::North }
    let(:rover) { Rover.new(x, y, direction) }
    let(:command) { nil }

    context 'with invalid command' do
      let(:command) { 'A' }

      it { expect { rover.parse_commands(command) }.to raise_error(RuntimeError) }
    end

    context 'with individual command' do
      subject! { rover.parse_commands(command) }

      describe 'forward' do
        let(:command) { 'F' }

        context "when facing north" do
          let(:direction) { Direction::North }

          it { is_expected.to eql('(0, 1) NORTH') }
          it { expect(rover.y).to eql(1) }
          it { expect(rover.x).to eql(0) }
        end

        context "when facing east" do
          let(:direction) { Direction::East }

          it { is_expected.to eql('(1, 0) EAST') }
          it { expect(rover.y).to eql(0) }
          it { expect(rover.x).to eql(1) }
        end

        context "when facing south" do
          let(:direction) { Direction::South }

          it { is_expected.to eql('(0, -1) SOUTH') }
          it { expect(rover.y).to eql(-1) }
          it { expect(rover.x).to eql(0) }
        end

        context "when facing west" do
          let(:direction) { Direction::West }

          it { is_expected.to eql('(-1, 0) WEST') }
          it { expect(rover.y).to eql(0) }
          it { expect(rover.x).to eql(-1) }
        end
      end

      describe 'backward' do
        let(:command) { 'B' }

        context "when facing north" do
          let(:rover) { Rover.new(x, y, direction) }

          it { is_expected.to eql('(0, -1) NORTH') }
          it { expect(rover.y).to eql(-1) }
          it { expect(rover.x).to eql(0) }
        end

        context "when facing east" do
          let(:direction) { Direction::East }

          it { is_expected.to eql('(-1, 0) EAST') }
          it { expect(rover.y).to eql(0) }
          it { expect(rover.x).to eql(-1) }
        end

        context "when facing south" do
          let(:direction) { Direction::South }

          it { is_expected.to eql('(0, 1) SOUTH') }
          it { expect(rover.y).to eql(1) }
          it { expect(rover.x).to eql(0) }
        end

        context "when facing west" do
          let(:direction) { Direction::West }

          it { is_expected.to eql('(1, 0) WEST') }
          it { expect(rover.y).to eql(0) }
          it { expect(rover.x).to eql(1) }
        end
      end

      describe 'rotate_right' do
        let(:command) { 'R' }

        context 'when facing north' do
          let(:direction) { Direction::North }

          it { expect(rover.direction).to eql(Direction::East) }
        end

        context 'when facing east' do
          let(:direction) { Direction::East }

          it { expect(rover.direction).to eql(Direction::South) }
        end

        context 'when facing south' do
          let(:direction) { Direction::South }

          it { expect(rover.direction).to eql(Direction::West) }
        end

        context 'when facing west' do
          let(:direction) { Direction::West }

          it { expect(rover.direction).to eql(Direction::North) }
        end
      end

      describe 'rotate_left' do
        let(:command) { 'L' }

        context 'when facing north' do
          let(:direction) { Direction::North }

          it { expect(rover.direction).to eql(Direction::West) }
        end

        context 'when facing east' do
          let(:direction) { Direction::East }

          it { expect(rover.direction).to eql(Direction::North) }
        end

        context 'when facing south' do
          let(:direction) { Direction::South }

          it { expect(rover.direction).to eql(Direction::East) }
        end

        context 'when facing west' do
          let(:direction) { Direction::West }

          it { expect(rover.direction).to eql(Direction::South) }
        end
      end
    end

    describe 'with several commands' do
      let(:x) { 4 }
      let(:y) { 2 }
      let(:direction) { Direction::East }
      let(:commands) { 'FLFFFRFLB' }
      let(:rover) { Rover.new(x, y, direction) }

      context 'with valid commands' do
        subject! { rover.parse_commands(commands) }

        it { is_expected.to eql('(6, 4) NORTH') }
        it { expect(rover.x).to eql(6) }
        it { expect(rover.y).to eql(4) }
        it { expect(rover.direction).to eql(Direction::North) }
      end
    end
  end
end
