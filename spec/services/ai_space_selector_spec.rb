require 'rails_helper'

describe AiSpaceSelector do
  let(:target_board) { Board.new }
  subject{ AiSpaceSelector.new(target_board)}

  it "fires at random coordinate on board" do
    subject.fire!

    expect(target_board.board.flatten.one? {|grid| grid.values.first.status == "Miss"}).to eq(true)
  end
end
