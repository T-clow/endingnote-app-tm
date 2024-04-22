class MemorialPhoto < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :photo, presence: true
  validates :visible_to, inclusion: { in: ['family'] }
  validates :comment, length: { maximum: 100 }
  validate :photo_count_within_limit, on: :create
  validate :acceptable_image

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

  def acceptable_image
    return unless photo.attached?

    unless photo.content_type.in?(%w(image/jpeg image/png))
      errors.add(:photo, 'はJPEGまたはPNG形式である必要があります')
    end

    if photo.byte_size > 20.megabytes
      errors.add(:photo, 'のサイズは20MB以下である必要があります')
    end
  end
end
