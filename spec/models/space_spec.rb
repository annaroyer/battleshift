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

  context 'instance methods' do
    describe '#attack!' do
      it "attacks it's contents and returns whether it was a hit or miss" do
        ship = spy("ship")
        space = Space.new('A1')
        allow(space).to receive(:contents).and_return(ship)

        with_a_ship = space.attack!

        expect(ship).to have_received(:attack!)
        expect(with_a_ship).to eq('Hit')
        expect(space.status).to eq('Hit')

        space_2 = Space.new('A2')

        without_a_ship = space_2.attack!

        expect(without_a_ship).to eq('Miss')
        expect(space_2.status).to eq('Miss')
      end
    end
  end
end
