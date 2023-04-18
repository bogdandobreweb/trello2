class AddAttributesInStories < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :status, :string, default: "In progress"
    add_column :stories, :due_date, :date, default: "2023-04-30"
  end
end
