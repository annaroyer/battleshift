class ApiController < ActionController::API
  before_action :require_api_key

  def require_game
    render status: 400 unless current_game
  end

  def require_api_key
    render status: 401, json: {message: "Unauthorized"} if invalid_api_key?
  end

  def invalid_api_key?
    users = User.where(api_key: request.headers["X-API-KEY"])
    users.empty? || users.first.inactive?
  end

  def current_player
    case request.headers['X-API-KEY']
    when current_game.player_1.api_key then current_game.player_1
    when current_game.player_2.api_key then current_game.player_2
    end
  end

  def current_game
    game_id = params[:game_id] || params[:id]
    @game ||= Game.find(game_id) unless Game.where(id: game_id).empty?
  end
end
