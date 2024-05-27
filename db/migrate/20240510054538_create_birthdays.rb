class CreateBirthdays < ActiveRecord::Migration[7.1]
  def change
    create_table :birthdays do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_of_birth, null: false

      t.timestamps
    end
  end
end
