require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効な属性の場合、ユーザーは有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it '電話番号がない場合、無効であること' do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("を入力してください")
    end

    it 'ユーザ名がない場合、無効であること' do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it '電話番号が数値でない場合、無効であること' do
      user = build(:user, phone_number: 'abcdefghij')
      user.valid?
      expect(user.errors[:phone_number]).to include("は数値で入力してください")
    end

    it '名前がない場合、無効であること' do
      user = build(:user, full_name: nil)
      user.valid?
      expect(user.errors[:full_name]).to include("を入力してください")
    end
  end

  describe '.guest' do
    it 'ゲストユーザーを作成または取得できること' do
      guest_user = User.guest
      expect(guest_user.email).to eq('guest@example.com')
    end
  end

  describe '#guest?' do
    it 'ゲストユーザーの場合、trueを返すこと' do
      guest_user = User.guest
      expect(guest_user.guest?).to be true
    end

    it 'ゲストユーザーでない場合、falseを返すこと' do
      non_guest_user = create(:user, email: 'non_guest@example.com')
      expect(non_guest_user.guest?).to be false
    end
  end
end
