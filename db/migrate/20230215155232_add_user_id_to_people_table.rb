class AddUserIdToPeopleTable < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :user_id, :integer, foreign_key: true, null: false
  end
end
