require 'rails_helper'

RSpec.describe InsurancePolicy, type: :model do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let(:insurance_policy) { build(:insurance_policy, user: user, insurance_amount: 1000) }

  describe 'バリデーション' do
    it '保険会社が必須であること' do
      insurance_policy.insurance_company = nil
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_company]).to include("を入力してください")
    end

    it '保険の種類が必須であること' do
      insurance_policy.insurance_type = nil
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_type]).to include("を入力してください")
    end

    it '保険金額が必須であること' do
      insurance_policy.insurance_amount = nil
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_amount]).to include("を入力してください")
    end

    it '保険期間が必須であること' do
      insurance_policy.insurance_period = nil
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_period]).to include("を入力してください")
    end

    it '保険金額が1万円以上であること' do
      insurance_policy.insurance_amount = 0
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_amount]).to include("は1万円〜1億円以下でご設定ください")
    end

    it '保険金額が1億円以下であること' do
      insurance_policy.insurance_amount = 1_000_000_000
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_amount]).to include("は1万円〜1億円以下でご設定ください")
    end

    it '保険会社の名前が20文字以内であること' do
      insurance_policy.insurance_company = 'a' * 21
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_company]).to include("は20文字以内で入力してください")
    end

    it '保険の種類が20文字以内であること' do
      insurance_policy.insurance_type = 'a' * 21
      expect(insurance_policy).not_to be_valid
      expect(insurance_policy.errors[:insurance_type]).to include("は20文字以内で入力してください")
    end
  end

  describe 'コールバック' do
    it '保険金額を円に変換すること' do
      insurance_policy.save
      expect(insurance_policy.reload.insurance_amount).to eq 10_000_000
    end
  end
end
