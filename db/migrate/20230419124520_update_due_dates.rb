class UpdateDueDates < ActiveRecord::Migration[7.0]
  def change
    new_due_date = Date.new(2023, 5, 1)
    Story.update_all(due_date: new_due_date)
  end
end
