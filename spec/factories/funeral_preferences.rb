FactoryBot.define do
  factory :funeral_preference do
    association :user
    funeral_type { '家族葬にして欲しい' }
    budget { '世間に恥じない一般的な金額にして欲しい' }
    invitees { '10人以下' }
    location { '自宅' }
    sect { '仏教' }
  end
end
