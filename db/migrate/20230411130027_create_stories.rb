class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.references :columns, null: false, foreign_key: true
      t.integer :position
      t.text :description

      t.timestamps
    end
  end
end
