require 'rails_helper'

describe Board do
  subject { Board.new }

  it "initializes with attributes" do
    expect(subject.length).to eq(4)
    expect(subject.board.flatten.first.values.first.coordinates).to eq("A1")
  end

  describe "instance methods" do
    context "#get_row_letters" do
      it "returns first 4 letters of alphabet" do
        expect(subject.get_row_letters).to eq(["A", "B", "C", "D"])
      end
    end

    context "#get_column_numbers" do
      it "returns first 4 numbers" do
        expect(subject.get_column_numbers).to eq(["1", "2", "3", "4"])
      end
    end

    context "#space_names" do
      it "returns array of coordinates" do
        coordinates = subject.space_names

        expect(coordinates[0]).to eq ("A1")
        expect(coordinates[4]).to eq ("B1")
      end
    end

    context "#create_spaces" do
      it "returns hash of coordinates and spaces" do
        spaces = subject.create_spaces

        expect(spaces["A1"].coordinates).to eq("A1")
      end
    end

    context "#assign_spaces_to_rows" do
      it "creates array of rows" do
        rows = subject.assign_spaces_to_rows

        expect(rows[0]).to eq(["A1", "A2", "A3", "A4"])
        expect(rows[3]).to eq(["D1", "D2", "D3", "D4"])
      end
    end

    context "#create_grid" do
      it "creates grid" do
        grid = subject.create_grid

        expect(subject.create_grid.first.first["A1"].coordinates).to eq("A1")
        expect(subject.create_grid[1].first["B1"].coordinates).to eq("B1")
      end
    end

    context "#locate_space" do
      it "returns specified space" do
        space = subject.locate_space("B2")

        expect(space.coordinates).to eq("B2")
      end
    end

    context "#conquered?" do
      it "returns true if board is conquered" do
        result = subject.conquered?

        expect(result).to eq(true)
      end

      it "returns false if board is not conquered" do
        space = double("space")
        ship = double("ship")
        content = double("content")
        allow(subject).to receive(:board) { [space] }
        allow(space).to receive(:values) { [ship] }
        allow(ship).to receive(:contents) { content }
        allow(content).to receive(:is_sunk?) { false }

        result = subject.conquered?

        expect(result).to eq(false)
      end
    end

    context "#spaces_occupied" do
      it "returns number of spaces occupied" do
        number_occupied = subject.spaces_occupied

        expect(number_occupied).to eq(0)

        space = double("space")
        ship = double("ship")
        content = double("content")
        allow(subject).to receive(:board) { [space] }
        allow(space).to receive(:values) { [ship] }
        allow(ship).to receive(:contents) { content }

        number_occupied = subject.spaces_occupied

        expect(number_occupied).to eq(1)
      end
    end
  end
end
