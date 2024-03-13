class FuneralPreference < ApplicationRecord
  belongs_to :user

  FUNERAL_TYPES = ['家族葬', '一般葬', '社葬', '直葬', '密葬'].freeze
  BUDGETS = ['〜100万円', '100万円〜300万円', '300万円〜500万円', '500万円〜'].freeze
  INVITEES = ['10人以下', '10人〜50人', '50人〜100人', '100人以上'].freeze
  LOCATIONS = ['自宅', '葬儀場', '寺院', 'その他'].freeze
  SECTS = ['仏教', 'キリスト教', '神道', '無宗教', 'その他'].freeze
end
