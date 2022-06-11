# Robot class will store current robot's facing orientation
# and the next move based on current facing direction
class Robot
  attr_accessor :direction

  # VALID_directions are orderecd clockwise
  VALID_DIRECTIONS = %i[north east south west].freeze
  # MOVES stores moving margin based on facing direction
  MOVES = {
    north: { x: 0, y: 1 },
    south: { x: 0, y: -1 },
    west: { x: -1, y: 0 },
    east: { x: 1, y: 0 }
  }

  def orientation(direction)
    return unless VALID_DIRECTIONS.include?(direction)

    @direction = direction
  end

   # when turning left, face the previous orientation anti-clockwise: N -> W -> S -> E
  def left
    new_direction_index = (VALID_DIRECTIONS.index(@direction) - 1) % 4
    @direction = VALID_DIRECTIONS[new_direction_index]

    nil
  end

  # when turning right, face the next orientation clockwise: N -> E -> S -> W
  def right
    new_direction_index = (VALID_DIRECTIONS.index(@direction) + 1) % 4
    @direction = VALID_DIRECTIONS[new_direction_index]

    nil
  end

  def facing_any_direction?
    !@direction.nil?
  end

  def move
    MOVES[@direction]
  end

end
