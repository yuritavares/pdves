class Dve < ApplicationRecord
  before_save :day_kind_values

  belongs_to :user

  validates :event_name, :event_date, :day_kind, presence: true

  enum day_kind: %i[Final_de_semana Dia_de_semana Feriado]

  def day_kind_values
    self.total = 0
    self.total += 20.00 if overnight == true
    self.total += if day_kind == 'Final_de_semana'
                    36.00
                  elsif day_kind == 'Dia_de_semana'
                    18.00
                  else
                    36.00
                  end
  end
end
