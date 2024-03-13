FactoryBot.define do
  factory :user do
    full_name { "テスト太郎" }
    username { "testuser" }
    phone_number { "1234567890" }
    email { "test@example.com" }
    password { "password" }
  end
end
