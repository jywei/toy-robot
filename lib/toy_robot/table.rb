# Table class will store current robot's position (coordinates) on the table
class Table

  attr_accessor :current_position

  def initialize(row = 5, column = 5)
    @row = row
    @column = column
  end

  def place(x, y)
    return unless valid_coordinates?(x, y)

    @current_position = { x: x, y: y }
  end

  def robot_being_placed?
    !@current_position.nil?
  end

  private

    def valid_coordinates?(x, y)
      (0..@column - 1).cover?(x) && (0..@row - 1).cover?(y)
    end

end
