class Ticket < ApplicationRecord
	belongs_to :bus
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
  enum status: [:Pending, :Confirmed, :Rejected, :Cancelled]
end
