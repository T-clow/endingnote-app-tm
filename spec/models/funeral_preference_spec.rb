require 'rails_helper'

RSpec.describe FuneralPreference, type: :model do
  describe 'バリデーションのテスト' do
    let(:funeral_preference) { FactoryBot.build(:funeral_preference) }

    it '全ての属性が正しく設定されていれば有効であること' do
      expect(funeral_preference).to be_valid
    end

    it '葬儀の種類が設定されていなければ無効であること' do
      funeral_preference.funeral_type = ''
      expect(funeral_preference).not_to be_valid
    end

    it '予算が設定されていなければ無効であること' do
      funeral_preference.budget = ''
      expect(funeral_preference).not_to be_valid
    end

    it '呼ぶ人の数が設定されていなければ無効であること' do
      funeral_preference.invitees = ''
      expect(funeral_preference).not_to be_valid
    end

    it '場所が設定されていなければ無効であること' do
      funeral_preference.location = ''
      expect(funeral_preference).not_to be_valid
    end

    it '宗派が設定されていなければ無効であること' do
      funeral_preference.sect = ''
      expect(funeral_preference).not_to be_valid
    end
  end
end
