class Dve < ApplicationRecord
    validates :event_name, :event_date, presence: true
end
