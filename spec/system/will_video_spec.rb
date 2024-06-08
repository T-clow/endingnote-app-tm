require 'rails_helper'

RSpec.describe "WillVideos", type: :system do
  let(:user) { create(:user) }
  let(:video_path) { Rails.root.join('spec/fixtures/files/valid_video.mp4') }
  let(:large_video_path) { Rails.root.join('spec/fixtures/files/large_video.mp4') }
  let(:invalid_video_path) { Rails.root.join('spec/fixtures/files/invalid_video.wmv') }
  let(:video_content_type) { 'video/mp4' }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "動画のアップロード" do
    context '有効なビデオファイルの場合' do
      it "ユーザーは新しい動画をアップロードできる" do
        visit new_user_will_video_path(user)
        attach_file 'will_video[video]', video_path
        click_button '登録'
        expect(page).to have_content('遺言動画をアップロードしました。')
        expect(WillVideo.last).to be_persisted
      end
    end

    context '無効なビデオファイルの場合' do
      it "大きすぎるファイルはアップロードに失敗すること" do
        visit new_user_will_video_path(user)
        attach_file 'will_video[video]', large_video_path, visible: false
        click_button '登録'
        expect(page).to have_content('のサイズが大きすぎます。80MB以下のファイルを選択してください。')
        expect(WillVideo.count).to eq(0)
      end

      it "不正な形式のファイルはアップロードに失敗すること" do
        visit new_user_will_video_path(user)
        attach_file 'will_video[video]', invalid_video_path, visible: false
        click_button '登録'
        expect(page).to have_content('サポートされていないファイル形式です。')
        expect(WillVideo.count).to eq(0)
      end
    end
  end

  describe "動画の表示" do
    let!(:will_video) { create(:will_video, user: user) }

    it "ユーザーは動画の詳細ページを表示できる" do
      will_video.video.attach(io: File.open(video_path), filename: 'valid_video.mp4', content_type: video_content_type)
      visit user_will_video_path(user, will_video)
      expect(page).to have_selector('video')
    end
  end

  describe "動画の削除" do
    let!(:will_video) { create(:will_video, user: user) }

    it "ユーザーは動画を削除できる" do
      will_video.video.attach(io: File.open(video_path), filename: 'valid_video.mp4', content_type: video_content_type)
      visit edit_user_will_video_path(user, will_video)
      find('.btn-danger', text: '動画を削除').click
      accept_alert
      expect(page).to have_content('動画が正常に削除されました。')
    end
  end
end
