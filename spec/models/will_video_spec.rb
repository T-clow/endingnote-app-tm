require 'rails_helper'

RSpec.describe WillVideo, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーション' do
    let(:valid_video) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/valid_video.mp4'), 'video/mp4') }
    let(:large_video) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/large_video.mp4'), 'video/mp4') }
    let(:invalid_video) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/invalid_video.wmv'), 'video/x-ms-wmv') }

    it '有効なファイル形式でバリデーションが通ること' do
      video = build(:will_video, user: user)
      video.video.attach(io: File.open(valid_video.path), filename: File.basename(valid_video.path), content_type: 'video/mp4')
      expect(video).to be_valid
    end

    it 'サイズが大きすぎる場合にバリデーションエラーが発生すること' do
      video = build(:will_video, user: user)
      video.video.attach(io: File.open(large_video.path), filename: File.basename(large_video.path), content_type: 'video/mp4')
      expect(video).not_to be_valid
      expect(video.errors[:video]).to include('のサイズが大きすぎます。80MB以下のファイルを選択してください。')
    end

    it 'サポートされていないファイル形式の場合にバリデーションエラーが発生すること' do
      video = build(:will_video, user: user)
      video.video.attach(io: File.open(invalid_video.path), filename: File.basename(invalid_video.path), content_type: 'video/x-ms-wmv')
      expect(video).not_to be_valid
      expect(video.errors[:video]).to include('サポートされていないファイル形式です。')
    end

    it '正しく動画ファイルがアップロードされこと' do
      video_path = Rails.root.join('spec', 'fixtures', 'files', 'valid_video.mp4')
      file = Rack::Test::UploadedFile.new(video_path, 'video/mp4')

      video = build(:will_video)
      video.video.attach(io: File.open(file.path), filename: 'valid_video.mp4', content_type: 'video/mp4')

      expect(video).to be_valid
    end
  end
end
