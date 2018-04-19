class Direction
  def self.right
    ORDERED_DIRECTIONS[(ORDERED_DIRECTIONS.index(self) + 1) % ORDERED_DIRECTIONS.length]
  end

  def self.left
    ORDERED_DIRECTIONS[(ORDERED_DIRECTIONS.index(self) - 1) % ORDERED_DIRECTIONS.length]
  end

  def self.forward
    FORWARD_DIRECTIONS[self]
  end

  def self.backward
    self.forward.map { |i| -i }
  end

  def self.to_s
    self.name.split('::').last.upcase
  end

  class North < Direction
  end

  class East < Direction
  end

  class South < Direction
  end

  class West < Direction
  end

  ORDERED_DIRECTIONS = [Direction::North, Direction::East, Direction::South, Direction::West]
  FORWARD_DIRECTIONS = {
    Direction::North => [0, 1],
    Direction::East => [1, 0],
    Direction::South => [0, -1],
    Direction::West => [-1, 0]
  }
end
