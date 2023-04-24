class UpdateStoryStatuses < ActiveRecord::Migration[7.0]
  def up
    execute("UPDATE stories SET status = 1")
  end

  def down
    # revert the update if necessary
  end
end

