class Dve < ApplicationRecord
    validates :event_name, :event_date, :overnight, presence: true
end
