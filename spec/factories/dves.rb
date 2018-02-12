FactoryBot.define do
  factory :dfe, class: 'Dve' do
    event_name "MyString"
    event_date "2018-02-12 13:23:45"
    start_day "2018-02-12 13:23:45"
    end_day "2018-02-12 13:23:45"
    total_hours 1
    ex_time 1
    overnight ""
  end
end
