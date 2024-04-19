require 'rails_helper'

RSpec.describe MemorialPhoto, type: :model do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:memorial_photo) { build(:memorial_photo, user: user) }

    context '正常なデータの場合' do
      it '画像が適切にアップロードされること' do
        memorial_photo.photo.attach(io: File.open(Rails.root.join('spec/fixtures/files/image.jpg')), filename: 'image.jpg', content_type: 'image/jpeg')
        expect(memorial_photo).to be_valid
      end
    end

    context 'ファイル形式のバリデーション' do
      it 'JPEG形式の場合は有効であること' do
        memorial_photo.photo.attach(io: File.open(Rails.root.join('spec/fixtures/files/image.jpg')), filename: 'image.jpg', content_type: 'image/jpeg')
        expect(memorial_photo).to be_valid
      end

      it 'PNG形式の場合は有効であること' do
        memorial_photo.photo.attach(io: File.open(Rails.root.join('spec/fixtures/files/image.png')), filename: 'image.png', content_type: 'image/png')
        expect(memorial_photo).to be_valid
      end

      it '許可されていない形式の場合は無効であること' do
        memorial_photo.photo.attach(io: File.open(Rails.root.join('spec/fixtures/files/image.gif')), filename: 'image.gif', content_type: 'image/gif')
        expect(memorial_photo).to be_invalid
        expect(memorial_photo.errors[:photo]).to include('はJPEGまたはPNG形式である必要があります')
      end
    end

    context 'ファイルサイズのバリデーション' do
      it 'ファイルサイズが20MBを超える場合は無効であること' do
        memorial_photo.photo.attach(io: File.open(Rails.root.join('spec/fixtures/files/image_large.jpg')), filename: 'image_large.jpg', content_type: 'image/gif')
        expect(memorial_photo).to be_invalid
        expect(memorial_photo.errors[:photo]).to include('のサイズは20MB以下である必要があります')
      end
    end

    context 'コメントの長さのバリデーション' do
      it 'コメントが100文字以内の場合は有効であること' do
        memorial_photo.comment = 'a' * 100
        expect(memorial_photo).to be_valid
      end

      it 'コメントが100文字を超える場合は無効であること' do
        memorial_photo.comment = 'a' * 101
        expect(memorial_photo).to be_invalid
        expect(memorial_photo.errors[:comment]).to include('は100文字以内で入力してください')
      end
    end

    context '写真の枚数制限' do
      it '3枚まで投稿可能であること' do
        create_list(:memorial_photo, 2, user: user)
        expect(memorial_photo).to be_valid
      end

      it '4枚目の投稿は無効であること' do
        create_list(:memorial_photo, 3, user: user)
        expect(memorial_photo).to be_invalid
        expect(memorial_photo.errors[:base]).to include('画像は3枚まで投稿可能です')
      end
    end
  end
end
