class CreateMemorialPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :memorial_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :visible_to

      t.timestamps
    end
  end
end
