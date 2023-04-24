class Board < ApplicationRecord
    acts_as_paranoid
    has_paper_trail
    has_many :columns, -> { order(position: :asc) }, dependent: :destroy
    belongs_to :user
end
