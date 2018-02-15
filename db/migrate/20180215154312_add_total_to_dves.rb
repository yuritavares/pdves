class AddTotalToDves < ActiveRecord::Migration[5.1]
  def change
    add_column :dves, :second_start, :time
    add_column :dves, :second_end, :time
    add_column :dves, :day_kind, :integer
    add_column :dves, :total, :decimal
    remove_column :dves, :total_hours
    remove_column :dves, :ex_time
    change_column :dves, :event_date, :date
    change_column :dves, :start_day, :time
    change_column :dves, :end_day, :time
  end
end
