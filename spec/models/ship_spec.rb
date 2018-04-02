require 'rails_helper'

describe Ship do
  subject { Ship.new(3) }

  it "initializes with attributes" do
    expect(subject.length).to eq(3)
    expect(subject.damage).to eq(0)
  end

  describe "instance_methods" do
    context "#attack!" do
      it "increments ship damage" do
        subject.attack!

        expect(subject.damage).to eq(1)

        subject.attack!

        expect(subject.damage).to eq(2)
      end
    end

    context "#is_sunk" do
      it "returns true if damage = length" do
        expect(subject.is_sunk?).to eq(false)

        2.times { subject.attack! }

        expect(subject.is_sunk?).to eq(false)

        subject.attack!

        expect(subject.is_sunk?).to eq(true)
      end
    end
  end
end
