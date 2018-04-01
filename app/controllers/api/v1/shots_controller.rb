class Api::V1::ShotsController < ApiController
  before_action :require_game, :require_current_turn

  def create
    opponent_board = case request.headers['X-API-KEY']
                     when current_game.player_1.api_key then current_game.player_2.board
                     when current_game.player_2.api_key then current_game.player_1.board
                     end

    turn_processor = TurnProcessor.new(current_game, params[:shot][:target], opponent_board, current_player)
    turn_processor.run!

    render status: turn_processor.status, json: current_game, message: turn_processor.message
  end

  private
    def require_current_turn
      render status: 400, json: current_game, message: "Invalid move. It's your opponent's turn." unless correct_player?
    end

    def correct_player?
      players[request.headers["X-API-KEY"]] == current_game.current_turn
    end

    def players
      {current_game.player_1.api_key => "player_1", current_game.player_2.api_key => "player_2"}
    end
end
