require 'rails_helper'

describe Space do
  context 'attributes' do
    it 'has coordinates' do
      space = Space.new('A1')

      expect(space.coordinates).to eq('A1')
    end

    it 'has contents' do
      ship = Ship.new(2)
      ShipPlacer.new()
      space = Space.new('A1')
    end
  end
end
