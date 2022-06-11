require "spec_helper"

describe "Robot" do
  let(:robot) { Robot.new }

  describe "#orientation" do
    it "allows orientation to be :north, :south, :east and :west" do
      %i[north east south west].each do |input_direction|
        expect(robot.orientation(input_direction)).to eq input_direction
        expect(robot.direction).to eq input_direction
      end
    end

    it "has to be a valid direction" do
      expect(robot.orientation(:test)).to be_nil
    end
  end

  describe "#move" do
    subject { robot.move }

    context "robot is facing north" do
      it "moves up" do
        robot.orientation(:north)

        expect(subject).to eq(x: 0, y: 1)
      end
    end

    context "robot is facing south" do
      it "moves down" do
        robot.orientation(:south)

        expect(subject).to eq(x: 0, y: -1)
      end
    end

    context "robot is facing west" do
      it "moves left" do
        robot.orientation(:west)

        expect(subject).to eq(x: -1, y: 0)
      end
    end

    context "robot is facing east" do
      it "moves right" do
        robot.orientation(:east)

        expect(subject).to eq(x: 1, y: 0)
      end
    end

  end

  describe "#left" do
    subject { robot.left }

    context "robot is facing north" do
      it "should face west" do
        robot.orientation(:north)
        subject

        expect(robot.direction).to eq :west
      end
    end

    context "robot is facing east" do
      it "should face north" do
        robot.orientation(:east)
        subject

        expect(robot.direction).to eq :north
      end
    end

    context "robot is facing south" do
      it "should face east" do
        robot.orientation(:south)
        subject

        expect(robot.direction).to eq :east
      end
    end

    context "robot is facing west" do
      it "should face south" do
        robot.orientation(:west)
        subject

        expect(robot.direction).to eq :south
      end
    end
  end

  describe "#right" do
    subject { robot.right }

    context "robot is facing north" do
      it "should face east" do
        robot.orientation(:north)
        subject

        expect(robot.direction).to eq :east
      end
    end

    context "robot is facing east" do
      it "should face south" do
        robot.orientation(:east)
        subject

        expect(robot.direction).to eq :south
      end
    end

    context "robot is facing south" do
      it "should face west" do
        robot.orientation(:south)
        subject

        expect(robot.direction).to eq :west
      end
    end

    context "robot is facing west" do
      it "should face north" do
        robot.orientation(:west)
        subject

        expect(robot.direction).to eq :north
      end
    end
  end

  describe "#facing_any_direction?" do
    context "robot is not set with any direction" do
      it "should return false" do
        expect(robot.facing_any_direction?).to be false
      end
    end

    context "robot is set with a direction" do
      it "should return true" do
        robot.orientation(:west)

        expect(robot.facing_any_direction?).to be true
      end
    end
  end
end
