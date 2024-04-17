class MemorialPhoto < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :photo, presence: true
  validates :visible_to, inclusion: { in: ['family'] }
  validate :photo_count_within_limit, on: :create

  after_initialize :set_default_visible_to

  private

  def set_default_visible_to
    self.visible_to ||= 'family'
  end

  def photo_count_within_limit
    if user.memorial_photos.count >= 3
      errors.add(:base, "画像は3枚まで投稿可能です")
    end
  end
end
