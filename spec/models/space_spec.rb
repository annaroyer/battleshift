require 'rails_helper'

describe Space do
  context 'attributes' do
    it 'has coordinates' do
      space = Space.new('A1')

      expect(space.coordinates).to eq('A1')
    end

    it 'has contents' do
      ship = Ship.new(2)
      board = Board.new
      ship_placer = ShipPlacer.new({board: board, ship: ship, start_space: 'A1', end_space: 'A2'})
      ship_placer.run
      space = board.locate_space('A1')

      expect(space.contents.class).to eq(Ship)
    end

    it "starts with status 'Not Attacked'" do
      space = Space.new('A1')

      expect(space.status).to eq('Not Attacked')
    end
  end
end
