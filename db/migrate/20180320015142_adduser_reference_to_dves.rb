class AdduserReferenceToDves < ActiveRecord::Migration[5.1]
  def change
    add_column :dves, :user_id, :integer
  end
end
