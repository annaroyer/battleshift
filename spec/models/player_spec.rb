require 'rails_helper'

describe Player do
  context 'attributes' do
    subject { Player.new(Board.new, "khadkjhfk0398") }

    it 'has a board, turns, and api_key' do
      expect(subject.board.class).to eq(Board)
      expect(subject.turns).to eq(0)
      expect(subject.api_key.class).to eq(String)
    end
  end
end
