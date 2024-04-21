require 'rails_helper'

RSpec.describe WillVideo, type: :model do
  let(:user) { create(:user) }
  let(:valid_video_path) { Rails.root.join('spec/fixtures/files/valid_video.mp4') }
  let(:large_video_path) { Rails.root.join('spec/fixtures/files/large_video.mp4') }
  let(:invalid_video_path) { Rails.root.join('spec/fixtures/files/invalid_video.wmv') }

  let(:valid_video) { Rack::Test::UploadedFile.new(valid_video_path, 'video/mp4') }
  let(:large_video) { Rack::Test::UploadedFile.new(large_video_path, 'video/mp4') }
  let(:invalid_video) { Rack::Test::UploadedFile.new(invalid_video_path, 'video/x-ms-wmv') }

  describe 'バリデーション' do
    let(:video) { build(:will_video, user: user) }

    before do
      video.video.attach(io: File.open(valid_video_path), filename: 'valid_video.mp4', content_type: 'video/mp4')
    end

    it '有効なファイル形式でバリデーションが通ること' do
      expect(video).to be_valid
    end

    it 'サイズが大きすぎる場合にバリデーションエラーが発生すること' do
      video.video.attach(io: File.open(large_video_path), filename: 'large_video.mp4', content_type: 'video/mp4')
      expect(video).not_to be_valid
      expect(video.errors[:video]).to include('のサイズが大きすぎます。80MB以下のファイルを選択してください。')
    end

    it 'サポートされていないファイル形式の場合にバリデーションエラーが発生すること' do
      video.video.attach(io: File.open(invalid_video_path), filename: 'invalid_video.wmv', content_type: 'video/x-ms-wmv')
      expect(video).not_to be_valid
      expect(video.errors[:video]).to include('サポートされていないファイル形式です。')
    end
  end
end
