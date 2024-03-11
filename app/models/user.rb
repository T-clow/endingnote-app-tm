class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { minimum: 10, maximum: 15 }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.full_name = "ゲスト"
      user.username = "ゲスト"
      user.phone_number = "0000000000"
    end
  end
end
