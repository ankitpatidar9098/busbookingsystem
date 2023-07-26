class Ticket < ApplicationRecord
	belongs_to :bus
    belongs_to :user
    belongs_to :route

  validates :name, presence: true, length: { minimum: 2 }
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true
end
