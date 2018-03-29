require 'rails_helper'

describe 'GET /api/v1/games/1' do
  context 'with an existing game' do
    it 'returns a game with boards' do
      player_1 = create(:player)
      player_2 = create(:opponent)
      sm_ship = Ship.new(2)
      md_ship = Ship.new(3)
      game = Game.create(
                          player_1: Player.new(Board.new, player_1.api_key),
                          player_2: Player.new(Board.new, player_2.api_key)
                        )

      ShipPlacer.new(board: game.player_1.board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2"
                    ).run

      ShipPlacer.new(board: game.player_1.board,
                     ship: md_ship,
                     start_space: "B1",
                     end_space: "D1"
                    ).run

      ShipPlacer.new(board: game.player_2.board,
                     ship: sm_ship.dup,
                     start_space: "A1",
                     end_space: "A2"
                    ).run

      ShipPlacer.new(board: game.player_2.board,
                     ship: md_ship.dup,
                     start_space: "B1",
                     end_space: "D1"
                    ).run



      get "/api/v1/games/#{game.id}", :headers => {"X-API-KEY" => player_1.api_key}

      actual  = JSON.parse(response.body, symbolize_names: true)
      expected = Game.last

      expect(response).to be_success
      expect(actual[:id]).to eq(expected.id)
      expect(actual[:current_turn]).to eq(expected.current_turn)
      expect(actual[:player_1_board][:rows].count).to eq(4)
      expect(actual[:player_2_board][:rows].count).to eq(4)
      expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")
    end
  end

  describe 'with no game' do
    it 'returns a 400' do
      user = create(:user)

      get "/api/v1/games/1", :headers => {"X-API-KEY" => user.api_key}

      expect(response.status).to be(400)
    end
  end
end
