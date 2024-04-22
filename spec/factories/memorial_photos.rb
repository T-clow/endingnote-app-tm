FactoryBot.define do
  factory :memorial_photo do
    association :user
    after(:build) do |memorial_photo|
      memorial_photo.photo.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/image.jpg')),
        filename: 'image.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
