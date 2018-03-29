class Api::V1::GamesController < ApiController
  before_action :require_game, only: [:show]

  def show
    render json: Game.find(params[:id])
  end

  def create
    player_1_api_key = request.headers['X-API-KEY']
    player_2_api_key = User.find_by(email: params[:opponent_email]).api_key
    game_attributes = {
      player_1: Player.new(Board.new, player_1_api_key),
      player_2: Player.new(Board.new, player_2_api_key)
    }
    game = Game.create(game_attributes)
    render json: game
  end
end
