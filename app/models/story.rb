class Story < ApplicationRecord
  belongs_to :column

  scope :in_progress, -> { where(status: "In progress")}
  scope :solved, -> { where(status: "Solved") }
  scope :old, -> { where('created_at > ?' Date.today-30)}
  scope :overdue, -> { where ("due_date < ?", Date.today)}
end
