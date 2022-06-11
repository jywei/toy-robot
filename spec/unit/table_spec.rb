require "spec_helper"

describe "Table" do
  let(:table) { Table.new }

  describe "#place" do
    it "has a valid placement" do
      expect(table.place(0, 0)).to_not be_nil
    end

    it "does not allow placement of X co-ordinate to be less than 0" do
      expect(table.place(-1, 0)).to be_nil
    end

    it "does not allow placement of X co-ordinate to be more than 4" do
      expect(table.place(5, 0)).to be_nil
    end

    it "does not allow placement of Y co-ordinate to be less than 0" do
      expect(table.place(0, -1)).to be_nil
    end

    it "does not allow placement of Y co-ordinate to be more than 4" do
      expect(table.place(0, 5)).to be_nil
    end
  end

  describe "#robot_being_placed?" do
    subject { table.robot_being_placed? }

    it "is initially false" do
      expect(subject).to eq false
    end

    context "robot is properly placed" do
      before { table.place(0, 0) }

      it "returns true" do
        expect(subject).to eq true
      end
    end

    context "robot is not placed properly" do
      before { table.place(10, 10) }

      it "returns false" do
        expect(subject).to eq false
      end
    end
  end

  describe "#current_position" do
    subject { table.current_position }

    it "is initially nil" do
      expect(subject).to be_nil
    end

    context "robot is properly placed" do
      before { table.place(0, 0) }

      it "returns the co-ordinates of the robot" do
        expect(subject).to eq(x: 0, y: 0)
      end
    end

    context "robot is not placed properly" do
      before(:each) { table.place(10, 10) }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end

end
