class AddColumnSidestatusToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :side_status, :string, default: "In Process"
  end
end
