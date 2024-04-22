require 'rails_helper'

RSpec.describe MemorialPhoto, type: :model do
  let(:user) { create(:user) }
  let(:image_path) { Rails.root.join('spec/fixtures/files/image.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path, 'image/jpeg') }

  describe 'バリデーション' do
    let(:memorial_photo) { build(:memorial_photo, user: user) }

    before do
      memorial_photo.photo.attach(io: File.open(image_path), filename: 'image.jpg', content_type: 'image/jpeg')
    end

    context '正常なデータの場合' do
      it '画像が適切にアップロードされること' do
        expect(memorial_photo).to be_valid
      end
    end

    context 'ファイル形式のバリデーション' do
      it 'JPEG形式の場合は有効であること' do
        expect(memorial_photo).to be_valid
      end

      it 'PNG形式の場合は有効であること' do
        png_image_path = Rails.root.join('spec/fixtures/files/image.png')
        memorial_photo.photo.attach(io: File.open(png_image_path), filename: 'image.png', content_type: 'image/png')
        expect(memorial_photo).to be_valid
      end

      it '許可されていない形式の場合は無効であること' do
        gif_image_path = Rails.root.join('spec/fixtures/files/image.gif')
        memorial_photo.photo.attach(io: File.open(gif_image_path), filename: 'image.gif', content_type: 'image/gif')
        expect(memorial_photo).to be_invalid
        expect(memorial_photo.errors[:photo]).to include('はJPEGまたはPNG形式である必要があります')
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
      before do
        2.times do
          photo = create(:memorial_photo, user: user)
          photo.photo.attach(io: File.open(image_path), filename: 'image.jpg', content_type: 'image/jpeg')
        end
      end

      it '3枚まで投稿可能であること' do
        new_photo = build(:memorial_photo, user: user)
        new_photo.photo.attach(io: File.open(image_path), filename: 'image.jpg', content_type: 'image/jpeg')
        expect(new_photo).to be_valid
      end

      it '4枚目の投稿は無効であること' do
        create(:memorial_photo, user: user).photo.attach(io: File.open(image_path), filename: 'image.jpg', content_type: 'image/jpeg')
        new_photo = build(:memorial_photo, user: user)
        new_photo.photo.attach(io: File.open(image_path), filename: 'image.jpg', content_type: 'image/jpeg')
        expect(new_photo).to be_invalid
        expect(new_photo.errors[:base]).to include('画像は3枚まで投稿可能です')
      end
    end
  end
end
