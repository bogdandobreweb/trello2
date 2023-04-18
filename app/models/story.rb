class Story < ApplicationRecord
  belongs_to :column

  scope :in_progress, -> { where(status: "In progress")}
  scope :solved, -> { where(status: "Solved") }
  scope :old, -> { where(Story.arel_table(:created_at).lt(Date.today-60))}
  scope :overdue, -> { where (Story.arel_table(:due_date).gt(Date.today))}

  scope :filter_by_status_and_date, -> (statuses, dates) {
    where(status: statuses).where(due_date: dates)
  }
end
