class ChangeDveEventDatetimToDate < ActiveRecord::Migration[5.1]
  def change
    change_column :dves, :event_date, :date
  end
end
