require "spec_helper"

describe "Simulator" do
  let(:simulator)          { Simulator.new }
  let(:invalid_message)    { "Invalid arguments passed after PLACE." }
  let(:not_placed_message) { "Robot is not placed yet!" }

  describe "#execute" do
    context "blank string" do
      it "ignores the command and warns the user" do
        expect(simulator.execute("")).to eq "Please enter something..."
      end
    end

    describe "before robot has been placed" do
      context "REPORT" do
        it "warns the user to place the robot first" do
          expect(simulator.execute("REPORT")).to eq not_placed_message
        end
      end

      describe "PLACE" do
        context "valid co-ordinates in a valid direction" do
          it "places the robot on the table" do
            simulator.execute("PLACE 0,1,NORTH")
          end
        end

        context "valid co-ordinates in an invalid direction or valid the table range" do
          it "does not place the robot on the table" do
            ["PLACE 0,1,TEST", "PLACE 0,10,NORTH"].each do |invalid_command|
              expect(simulator.execute(invalid_command)).to eq invalid_message
            end
          end
        end
      end

      context "`MOVE``, `RIGHT`, and `LEFT`" do
        it "warns the user to place the robot first" do
          %w[MOVE RIGHT LEFT].each do |action|
            expect(simulator.execute(action)).to eq not_placed_message
          end
        end
      end
    end

    describe "after the robot has been placed" do
      before { simulator.execute("PLACE 0,0,NORTH") }

      describe "PLACE" do
        context "valid co-ordinates in a valid direction" do
          it "places the robot on the table" do
            simulator.execute("PLACE 0,1,NORTH")
          end
        end

        context "valid co-ordinates in an invalid direction or valid the table range" do
          it "does not place the robot on the table" do
            ["PLACE 0,1,TEST", "PLACE 0,10,NORTH"].each do |invalid_command|
              expect(simulator.execute(invalid_command)).to eq invalid_message
            end
          end
        end
      end

      describe "REPORT" do
        it "returns the result" do
          expect(simulator.execute("REPORT")).to eq "0,0,NORTH"
        end
      end

      describe "MOVE" do
        context "when there are still rooms to move" do
          it "moves the robot" do
            simulator.execute("MOVE")
          end
        end

        context "robot is about to fall off the table" do
          it "warns the user and does not move the robot" do
            4.times { simulator.execute("MOVE") }

            expect(simulator.execute("MOVE")).to eq "WARNING: Robot will fall off the table"
          end
        end
      end
    end

    describe "LEFT" do
      it "should call turn_direction to turn left" do
        expect(simulator).to receive(:turn_direction).with("left")

        simulator.execute("LEFT")
      end
    end

    describe "RIGHT" do
      it "should call turn_direction to turn right" do
        expect(simulator).to receive(:turn_direction).with("right")

        simulator.execute("RIGHT")
      end
    end
  end
end
