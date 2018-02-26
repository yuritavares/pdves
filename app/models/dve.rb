class Dve < ApplicationRecord
  before_save :calculation
  validates :event_name, :event_date, :day_kind, presence: true

  enum day_kind: %i[Weekend Weekday Holiday]

  def calculation
    self.total = 0
    self.total += 20.00 if overnight == true
    self.total += if day_kind == 'Weekend'
                    36.00
                  elsif day_kind == 'Weekday'
                    18.00
                  else
                    36.00
                  end
  end

  def event_date_formatted
    event_date.strftime '%d/%m/%Y - %A'
  end

  def event_date_formatted=(value)
    self.event_date = Time.parse(value)
  end
end
