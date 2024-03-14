class FuneralPreference < ApplicationRecord
  belongs_to :user

  validates :funeral_type, :budget, :invitees, :location, :sect, presence: true

  FUNERAL_TYPES = ['家族葬にして欲しい', '小さなお葬式にして欲しい', '葬儀はせず火葬だけにして欲しい', '一般的な通夜と告別式の葬儀をして欲しい', '家族の判断に任せる'].freeze
  BUDGETS = ['世間に恥じない一般的な金額にして欲しい', 'できるだけお金をかけないで欲しい', '準備している金額で可能な限り盛大にして欲しい', '家族の判断に任せる'].freeze
  INVITEES = ['10人以下', '10人〜50人', '50人〜100人', '100人以上'].freeze
  LOCATIONS = ['自宅', '葬儀場', '寺院', '直葬(火葬場)', '家族の判断に任せる'].freeze
  SECTS = ['仏教', 'キリスト教', '神道', '無宗教', 'その他'].freeze
end
