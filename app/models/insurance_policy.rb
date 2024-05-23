class InsurancePolicy < ApplicationRecord
  belongs_to :user
  has_one_attached :policy_image
  before_validation :convert_amount_to_yen, if: :insurance_amount_changed?
  before_save :convert_amount_to_yen

  validates :insurance_company, :insurance_type, :insurance_amount, :insurance_period, presence: true
  validates :insurance_company, :insurance_type, length: { maximum: 20, message: "は20文字以内で入力してください" }
  validates :insurance_amount, numericality: { greater_than: 0, only_integer: true, message: "は1万円以上で入力してください" }
  validates :policy_number, length: { maximum: 20 }, format: { with: /\A[0-9A-Za-zァ-ンヴー]+\z/, message: "は半角英数字及びカタカナで入力してください" }, allow_blank: true
  validate :insurance_period_must_be_appropriate
  validate :insurance_period_within_limit, unless: -> { insurance_period == 100 }
  validate :acceptable_image, if: -> { policy_image.attached? }
  validates :note, length: { maximum: 100, message: "は100文字以内で入力してください" }

  INSURANCE_COMPANIES = [
    'アクサ生命', '朝日生命', 'アフラック生命',
    'イオン・アリアンツ生命', 'SBI生命', 'エヌエヌ生命',
    'FWD生命', 'オリックス生命', 'ジブラルタ生命',
    '住友生命相互会社', 'ソニー生命', 'SOMPOひまわり生命',
    '第一生命', '第一フロンティア生命', '大樹生命',
    'チューリッヒ生命', 'T&Dフィナンシャル生命', '東京海上日動あんしん生命',
    'なないろ生命', 'ニッセイ・ウェルス生命', '日本生命',
    'ネオファースト生命', 'はなさく生命', '富国生命', 'マニュライフ生命',
    '三井住友海上あいおい生命', '明治安田生命', 'メットライフ生命',
    'メディケア生命', 'ライフネット生命', '楽天生命', '都道府県民共済', 'かんぽ生命',
    'こくみん共済(旧全労災)', 'JA共済(農協)', 'JF共済(漁協)', 'COAP共済', '自治労共済', '公務員共済', '教職員共済',
  ].freeze

  INSURANCE_TYPES = [
    '終身保険', '定期保険', '養老保険', '医療保険', 'がん保険', '介護保険', '学資保険',
  ].freeze

  def self.insurance_amount_options
    (100..5000).step(100).map { |amount| [amount.to_s + '万円', amount] }
  end

  def self.insurance_period_options(user_age)
    start_age = (user_age % 5 == 0) ? user_age : (user_age / 5 + 1) * 5
    options = (start_age..95).step(5).map { |year| [year.to_s, year] }
    options.append(['終身', 100])
    options
  end

  private

  def convert_amount_to_yen
    if insurance_amount.present? && insurance_amount <= 10_000
      self.insurance_amount *= 10_000
    elsif insurance_amount.present? && insurance_amount > 10_000
      errors.add(:insurance_amount, "は1億円以下で入力してください")
    end
  end

  def insurance_period_must_be_appropriate
    Rails.logger.debug "Insurance Period: #{insurance_period}"
    return if insurance_period == 100
    if user && insurance_period && insurance_period < user.birthday.age
      errors.add(:insurance_period, "は現在の年齢以上である必要があります")
    end
  end

  def insurance_period_within_limit
    if insurance_period.present? && insurance_period > 99
      errors.add(:insurance_period, "は99歳以下である必要があります")
    end
  end

  def acceptable_image
    unless policy_image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:policy_image, 'はJPEGまたはPNG形式である必要があります')
    end

    if policy_image.byte_size > 20.megabytes
      errors.add(:policy_image, 'のサイズは20MB以下である必要があります')
    end
  end
end
