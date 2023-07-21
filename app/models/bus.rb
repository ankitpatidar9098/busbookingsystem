class Bus < ApplicationRecord
	belongs_to :route

    has_many :tickets, dependent: :destroy
    self.per_page = 12
end
