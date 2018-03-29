require 'rails_helper'

describe "post /api/v1/game" do
  it "creates a new game" do
    player = create(:player)
    opponent = create(:opponent)

    payload = {opponent_email: opponent.email}
    headers = {"X-API-KEY" => player.api_key}

    post "/api/v1/games", params: payload, :headers => headers

    actual_game = JSON.parse(response.body, symbolize_names: true)
    expected_game = Game.last

    expect(expected_game.id).to eq(actual_game[:id])
    expect(expected_game.player_1.api_key).to eq(player.api_key)
    expect(expected_game.player_2.api_key).to eq(opponent.api_key)
    expect(expected_game.player_1.board.board.first.first.keys.first).to eq(actual_game[:player_1_board][:rows].first[:data].first[:coordinates])
  end
end
