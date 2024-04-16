class MemorialPhoto < ApplicationRecord
  has_one_attached :photo
  validates :photo, presence: true
  validates :visible_to, inclusion: { in: ['family'] }

  after_initialize :set_default_visible_to

  private

  def set_default_visible_to
    self.visible_to ||= 'family'
  end
end
