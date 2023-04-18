class Board < ApplicationRecord
    has_many :columns, -> { order(position: :asc) }, dependent: :destroy
    
end
