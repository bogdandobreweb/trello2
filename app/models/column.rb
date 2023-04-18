class Column < ApplicationRecord
  belongs_to :board
  has_many :stories, -> { order(position: :asc) }, dependent: :destroy
end
