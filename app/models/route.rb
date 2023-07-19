class Route < ApplicationRecord
	 has_many :buses
     validates :from, :to, :first_bus, :last_bus, presence: true
end
