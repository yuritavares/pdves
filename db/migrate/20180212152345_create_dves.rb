class CreateDves < ActiveRecord::Migration[5.1]
  def change
    create_table :dves do |t|
      t.string :event_name
      t.datetime :event_date
      t.datetime :start_day
      t.datetime :end_day
      t.integer :total_hours
      t.integer :ex_time
      t.boolean :overnight

      t.timestamps
    end
  end
end
