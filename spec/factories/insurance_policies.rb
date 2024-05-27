FactoryBot.define do
  factory :insurance_policy do
    association :user
    insurance_company { "sample生命" }
    insurance_type { "がん保険" }
    insurance_amount { 1_000 }
    insurance_period { 90 }
    policy_number { "123456" }
    note { "備考" }
  end
end
