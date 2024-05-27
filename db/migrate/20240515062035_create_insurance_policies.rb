class CreateInsurancePolicies < ActiveRecord::Migration[7.1]
  def change
    create_table :insurance_policies do |t|
      t.string :insurance_company
      t.string :insurance_type
      t.integer :insurance_amount
      t.integer :insurance_period
      t.string :policy_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
