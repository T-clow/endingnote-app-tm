class User < ApplicationRecord
  has_one :funeral_preference
  has_one_attached :avatar
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: { message: "お名前を入力してください。" }
  validates :username, presence: { message: "ユーザ名を入力してください。" },
                       uniqueness: { message: "このユーザ名は既に使用されています。" }
  validates :phone_number, presence: { message: "電話番号を入力してください。" },
                           numericality: { only_integer: true, message: "電話番号は数値で入力してください。" },
                           length: { in: 10..15, too_short: "電話番号は10桁以上で入力してください。", too_long: "電話番号は15桁以下で入力してください。" }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.full_name = "ゲスト"
      user.username = "ゲスト"
      user.phone_number = "0000000000"
    end
  end

  def guest?
    email == 'guest@example.com'
  end
end
