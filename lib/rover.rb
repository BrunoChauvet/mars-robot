require_relative 'direction'

class Rover
  attr_reader :x, :y, :direction

  def initialize(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

  def parse_commands(commands)
    commands.each_char do |command|
      case command
      when 'F'
        @x, @y = *([[@x, @y], @direction.forward].transpose.map { |x| x.reduce(:+) })
      when 'B'
        @x, @y = *([[@x, @y], @direction.backward].transpose.map { |x| x.reduce(:+) })
      when 'R'
        @direction = @direction.right
      when 'L'
        @direction = @direction.left
      else
        raise 'Invalid command'
      end
    end

    "(#{@x}, #{@y}) #{@direction}"
  end
end
