class AddNoteToInsurancePolicies < ActiveRecord::Migration[7.1]
  def change
    add_column :insurance_policies, :note, :text
  end
end
