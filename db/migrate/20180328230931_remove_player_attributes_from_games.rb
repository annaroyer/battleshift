class RemovePlayerAttributesFromGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :player_1_board, :text
    remove_column :games, :player_2_board, :text
    remove_column :games, :player_1_turns, :integer
    remove_column :games, :player_2_turns, :integer
    change_column :games, :player_1, :text
    change_column :games, :player_2, :text
  end
end
