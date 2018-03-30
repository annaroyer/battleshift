class TurnProcessor
  attr_reader :status

  def initialize(game, target, opponent_board, current_player)
    @game   = game
    @messages = []
    @opponent_board = opponent_board
    @player = current_player
    @shooter = Shooter.new(board: opponent_board, target: target)
    @status = 200
  end

  def run!
    begin
      attack_opponent
    rescue InvalidAttack => e
      @messages << e.message
      @status = 400
    end
    game_status
    game.save!
  end

  def message
    @messages.compact.join(" ")
  end

  private
    attr_reader :game, :opponent_board, :player, :shooter

    def game_status
      if game_over?
        @messages << "Game over."
        game.winner ||= User.find_by(api_key: player.api_key).email
      end
    end

    def game_over?
      game.winner || opponent_board.conquered?
    end

    def attack_opponent
      raise InvalidAttack.new("Invalid move.") if game_over?
      result = shooter.fire!
      @messages << "Your shot resulted in a #{result}."
      switch_turns
    end

    def switch_turns
      @messages << shooter.message
      player.turns += 1
      game.current_turn = game.player_1.turns - game.player_2.turns
      game.save!
    end

    # def ai_attack_back
    #   result = AiSpaceSelector.new(player.board).fire!
    #   @messages << "The computer's shot resulted in a #{result}."
    #   game.player_2.turns += 1
    # end
end
