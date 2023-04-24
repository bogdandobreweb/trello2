class UpdateBoardUserIds < ActiveRecord::Migration[7.0]
  def up
    Board.update_all(user_id: 1)
  end

  def down
    Board.update_all(user_id: nil)
  end
end
