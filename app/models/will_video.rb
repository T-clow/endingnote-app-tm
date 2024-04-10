class WillVideo < ApplicationRecord
  belongs_to :user
  has_one_attached :video

  validate :video_presence

  private

  def video_presence
    if video.attached? && !valid_content_type?
      errors.add(:video, 'サポートされていないファイル形式です。')
    end
  end

  def valid_content_type?
    ['video/mp4', 'video/mov', 'video/mpeg', 'video/quicktime'].include?(video.blob.content_type)
  end
end
