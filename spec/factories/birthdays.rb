FactoryBot.define do
  factory :birthday do
    date_of_birth { Date.new(1990, 1, 1) }
    association :user
  end
end
