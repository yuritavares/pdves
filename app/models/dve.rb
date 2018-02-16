class Dve < ApplicationRecord
    before_save :calculation
    validates :event_name, :event_date, :day_kind, presence: true

    enum day_kind: %i[Weekend Weekday Holiday]

    def calculation
        self.total = 0
        if overnight == true
            self.total += 20.00
        end 
        if day_kind == 'Weekend'
            self.total += 36.00
        elsif day_kind == 'Weekday'
            self.total += 18.00
        else
            self.total += 36.00
        end
    end
end
