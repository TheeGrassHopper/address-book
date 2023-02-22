class CreatePhoneNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.text :comment
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
