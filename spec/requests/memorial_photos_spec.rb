require 'rails_helper'

RSpec.describe "MemorialPhotos", type: :request do
  let(:user) { create(:user) }
  let(:memorial_photo) { create(:memorial_photo, user: user) }
  let(:image_path) { Rails.root.join('spec/fixtures/files/image.jpg') }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "写真一覧ページに正常にアクセスできること" do
      get user_memorial_photos_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "写真詳細ページに正常にアクセスできること" do
      get user_memorial_photo_path(user, memorial_photo)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "写真新規作成ページに正常にアクセスできること" do
      get new_user_memorial_photo_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "有効なパラメータの場合" do
      it "新しい写真を投稿後詳細ページにアクセスすること" do
        post user_memorial_photos_path(user), params: {
          memorial_photo: {
            photo: fixture_file_upload(image_path, 'image/jpeg'),
            comment: "Test comment",
          },
        }
        expect(response).to redirect_to(user_memorial_photo_path(user, MemorialPhoto.last))
        follow_redirect!
        expect(response.body).to include("遺影画像をアップロードしました。")
      end
    end

    context "無効なパラメータの場合" do
      it "新しい写真が投稿されないこと" do
        expect do
          post user_memorial_photos_path(user), params: { memorial_photo: { photo: nil } }
        end.to_not change(MemorialPhoto, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "写真編集ページに正常にアクセスできること" do
      get edit_user_memorial_photo_path(user, memorial_photo)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "写真編集ページで写真を更新できること" do
      patch user_memorial_photo_path(user, memorial_photo), params: { memorial_photo: { comment: "Updated comment" } }
      memorial_photo.reload
      expect(memorial_photo.comment).to eq("Updated comment")
      expect(response).to redirect_to(user_memorial_photo_path(user, memorial_photo))
    end
  end

  describe "DELETE /destroy" do
    it "遺影写真をを削除できること" do
      memorial_photo
      expect do
        delete user_memorial_photo_path(user, memorial_photo)
      end.to change(MemorialPhoto, :count).by(-1)
      expect(response).to redirect_to("/")
      follow_redirect!
      expect(response.body).to include("画像が正常に削除されました")
    end
  end
end
