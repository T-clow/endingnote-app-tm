require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'バリデーション' do
    let(:contact) { build(:contact) }

    it '名前、メール、内容があれば有効であること' do
      expect(contact).to be_valid
    end

    it '名前がない場合は無効であること' do
      contact.name = nil
      contact.valid?
      expect(contact.errors[:name]).to include("を入力してください")
    end

    it 'メールアドレスがない場合は無効であること' do
      contact.email = nil
      contact.valid?
      expect(contact.errors[:email]).to include("を入力してください")
    end

    it '内容がない場合は無効であること' do
      contact.content = nil
      contact.valid?
      expect(contact.errors[:content]).to include("を入力してください")
    end

    it '名前が20文字を超える場合は無効であること' do
      contact.name = 'あ' * 21
      contact.valid?
      expect(contact.errors[:name]).to include("は20文字以内で入力してください")
    end

    it 'メールアドレスが30文字を超える場合は無効であること' do
      contact.email = 'a' * 31 + '@example.com'
      contact.valid?
      expect(contact.errors[:email]).to include("は30文字以内で入力してください")
    end

    it 'メールアドレスの形式が不正な場合は無効であること' do
      contact.email = 'invalid_email'
      contact.valid?
      expect(contact.errors[:email]).to include("は正しい形式で入力してください")
    end

    it '内容が500文字を超える場合は無効であること' do
      contact.content = 'a' * 501
      contact.valid?
      expect(contact.errors[:content]).to include("は500文字以内で入力してください")
    end
  end
end
