class AddCommentToMemorialPhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :memorial_photos, :comment, :text
  end
end
