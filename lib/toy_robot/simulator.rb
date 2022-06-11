# Simulator class will run the game, take the commands and execute robot's actions
class Simulator

  def initialize(table = Table.new)
    @table = table
    @robot = Robot.new
  end

  def execute(command)
    return "Please enter something..." if command.strip.empty?

    input = command.split(/\s+/)
    action, placement = input.first.downcase, input.last

    case action
    when "place"
      place(placement)
    when "report"
      report
    when "move"
      move
    when "left", "right"
      turn_direction(action)
    else
      "Invalid command: #{action}"
    end
  end

  private

    def robot_on_table?
      @table.robot_being_placed? && @robot.facing_any_direction?
    end

    def place(placement)
      args = placement.split(/,/)
      x, y = args[0].to_i, args[1].to_i
      facing = args[2].downcase.to_sym

      return if @robot.orientation(facing) && @table.place(x, y)

      "Invalid arguments passed after PLACE."
    rescue
      "Incorrect arguments passed after PLACE. Please provide the x, y coordinates and a facing direction."
    end

    def report
      return "Robot is not placed yet!" unless robot_on_table?

      current_position = @table.current_position
      facing = @robot.direction

      "#{current_position[:x]},#{current_position[:y]},#{facing.to_s.upcase}"
    end

    def move
      return "Robot is not placed yet!" unless robot_on_table?

      current_position = @table.current_position
      move = @robot.move

      return if @table.place(current_position[:x] + move[:x], current_position[:y] + move[:y])

      "WARNING: Robot will fall off the table"
    end

    def turn_direction(command)
      return "Robot is not placed yet!" unless robot_on_table?

      @robot.send(command.to_sym)
    end

end
