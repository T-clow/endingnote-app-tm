require 'rails_helper'

RSpec.describe FuneralPreference, type: :model do
  describe 'バリデーションのテスト' do
    let(:funeral_preference) { build(:funeral_preference) }

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

    it '備考が200文字以内であれば有効であること' do
      funeral_preference.remarks = 'a' * 200
      expect(funeral_preference).to be_valid
    end

    it '備考が200文字を超える場合は無効であること' do
      funeral_preference.remarks = 'a' * 201
      expect(funeral_preference).not_to be_valid
      expect(funeral_preference.errors[:remarks]).to include("は200文字以内にしてください。")
    end

    it '備考が空白でも有効であること' do
      funeral_preference.remarks = ''
      expect(funeral_preference).to be_valid
    end
  end
end
