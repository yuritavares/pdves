class Dve < ApplicationRecord
  before_save :calculation
  validates :event_name, :event_date, :day_kind, presence: true

  enum day_kind: %i[Final_de_semana Dia_de_semana Feriado]

  def calculation
    self.total = 0
    self.total += 20.00 if overnight == true
    self.total += if day_kind == 'Final de semana'
                    36.00
                  elsif day_kind == 'Dia de semana'
                    18.00
                  else
                    36.00
                  end
  end
end
