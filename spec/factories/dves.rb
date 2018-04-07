FactoryBot.define do
  factory :dve, class: 'Dve' do
    event_name "MyString"
    event_date "2018-02-12 13:23:45"
    start_day "2018-02-12 13:23:45"
    end_day "2018-02-12 13:23:45"
    second_start "2018-02-12 13:23:45"
    second_end "2018-02-12 13:23:45"
    day_kind 'Feriado'
    total nil
    overnight ""
    user
  end
end
