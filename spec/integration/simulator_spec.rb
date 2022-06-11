require "spec_helper"

describe "Simulator" do
  let(:simulator) { Simulator.new }

  subject do
    commands.each { |command| simulator.execute(command) }
    simulator.execute("REPORT")
  end

  describe "When placing the robot" do
    let(:commands) { ["PLACE 0,0,NORTH"] }

    it { is_expected.to eq "0,0,NORTH" }
  end

  describe "When moving the robot" do
    let(:commands) { ["PLACE 0,0,NORTH", "MOVE"] }

    it { is_expected.to eq "0,1,NORTH" }
  end

  describe "When turning the robot" do
    let(:commands) { ["PLACE 0,0,NORTH", "LEFT"] }

    it { is_expected.to eq "0,0,WEST" }
  end

  describe "When moving and turning the robot" do
    let(:commands) { ["PLACE 0,0,NORTH", "MOVE", "MOVE", "LEFT"] }

    it { is_expected.to eq "0,2,WEST" }
  end

  describe "When a command is issued before placing the robot" do
    let(:commands) { ["MOVE", "PLACE 0,0,NORTH"] }

    it "should ignore the command" do
      expect(subject).to eq("0,0,NORTH")
    end
  end

  describe "When a command will cause the robot to fall" do
    let(:commands) { ["PLACE 0,4,NORTH", "MOVE"] }

    it "should ignore the command" do
      expect(subject).to eq("0,4,NORTH")
    end
  end

  describe "When having two placements on the robot" do
    let(:commands) { ["PLACE 0,0,NORTH", "PLACE 0,0,SOUTH"] }

    it "should return the later placement" do
      is_expected.to eq("0,0,SOUTH")
    end
  end
end
