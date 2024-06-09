require 'rails_helper'

RSpec.describe WillVideosController, type: :request do
  let(:user) { create(:user) }
  let(:will_video) { create(:will_video, user: user) }

  before do
    sign_in user
  end

  describe 'GET /edit' do
    it '編集ページが正しく表示されること' do
      will_video.video.attach(io: File.open(Rails.root.join('spec/fixtures/files/valid_video.mp4')), filename: 'valid_video.mp4', content_type: 'video/mp4')
      get edit_user_will_video_path(user_id: user.id, id: will_video.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it '詳細ページが正しく表示されること' do
      will_video.video.attach(io: File.open(Rails.root.join('spec/fixtures/files/valid_video.mp4')), filename: 'valid_video.mp4', content_type: 'video/mp4')
      get user_will_video_path(user_id: user.id, id: will_video.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /destroy' do
    it '削除後にトップページにリダイレクトされること' do
      delete user_will_video_path(user, will_video)
      expect(response).to redirect_to("/")
    end
  end

  describe 'POST /create' do
    context '有効なパラメータの場合' do
      let(:valid_attributes) { { video: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'valid_video.mp4'), 'video/mp4') } }

      it '新しいWillVideoが作成されること' do
        expect do
          post user_will_videos_path(user), params: { will_video: valid_attributes }
        end.to change(WillVideo, :count).by(1)
        expect(response).to redirect_to(user_will_video_path(user, WillVideo.last))
      end
    end

    context '無効なパラメータの場合' do
      let(:invalid_attributes) { { video: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'large_video.mp4'), 'video/mp4') } }

      it '新しいWillVideoが作成されないこと' do
        expect do
          post user_will_videos_path(user), params: { will_video: invalid_attributes }
        end.not_to change(WillVideo, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
