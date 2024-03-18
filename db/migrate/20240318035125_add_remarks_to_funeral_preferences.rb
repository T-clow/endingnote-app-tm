class AddRemarksToFuneralPreferences < ActiveRecord::Migration[7.1]
  def change
    add_column :funeral_preferences, :remarks, :text
  end
end
