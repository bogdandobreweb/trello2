class ChangeStatusColumnTypeInStories < ActiveRecord::Migration[7.0]
  def change
        change_column :stories, :status, :integer, default: 1
  end
end
