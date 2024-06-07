class FuneralPreference < ApplicationRecord
  belongs_to :user

  validates :funeral_type, :budget, :invitees, :location, :sect, presence: true
  validates :remarks, length: { maximum: 200, message: "は200文字以内にしてください。" }, allow_blank: true

  FUNERAL_TYPES = ['家族葬にして欲しい', '小さなお葬式にして欲しい', '葬儀はせず火葬だけにして欲しい', '一般的な通夜と告別式の葬儀をして欲しい', '家族の判断に任せる'].freeze
  BUDGETS = ['50万円以下', '50〜100万円', '100〜200万円', '200〜300万円', '300万円以上'].freeze
  INVITEES = ['10人以下', '10〜50人', '50〜100人', '100人以上'].freeze
  LOCATIONS = ['自宅', '葬儀場', '寺院', '直葬(火葬場)', '家族の判断に任せる'].freeze
  SECTS = ['仏教', 'キリスト教', '神道', '無宗教', 'その他'].freeze
end
