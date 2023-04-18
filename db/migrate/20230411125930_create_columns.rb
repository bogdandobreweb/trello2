class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.string :name
      t.references :boards, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
