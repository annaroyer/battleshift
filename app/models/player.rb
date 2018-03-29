class Player
  attr_accessor :board, :turns
  attr_reader :api_key

  def initialize(board, api_key)
    @board = board
    @turns = 0
    @api_key = api_key
  end
end
