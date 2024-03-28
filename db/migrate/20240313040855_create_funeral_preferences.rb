class CreateFuneralPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :funeral_preferences do |t|
      t.string :funeral_type
      t.string :budget
      t.string :invitees
      t.string :location
      t.string :sect
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
