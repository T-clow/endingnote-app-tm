require 'rails_helper'

RSpec.describe "MemorialPhotos", type: :system do
  let(:user) { create(:user) }
  let(:image_path) { Rails.root.join('spec/fixtures/files/image.jpg') }
  let(:large_image_path) { Rails.root.join('spec/fixtures/files/image_large.jpg') }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "写真のアップロード" do
    it "有効な写真ファイルの場合、ユーザーは新しい写真をアップロードできる" do
      visit new_user_memorial_photo_path(user)
      attach_file 'memorial_photo[photo]', image_path
      fill_in 'memorial_photo[comment]', with: '新しいコメント'
      click_button 'アップロード'
      expect(page).to have_content('遺影画像をアップロードしました。')
      expect(MemorialPhoto.last).to be_persisted
      expect(MemorialPhoto.last.photo).to be_attached
    end

    it "大きすぎるファイルはアップロードに失敗すること" do
      visit new_user_memorial_photo_path(user)
      attach_file 'memorial_photo[photo]', large_image_path, visible: false
      click_button 'アップロード'
      expect(page).to have_content('画像のサイズは20MB以下である必要があります')
      expect(MemorialPhoto.count).to eq(0)
    end
  end

  describe "写真の表示" do
    let!(:memorial_photo) { create(:memorial_photo, user: user, photo: fixture_file_upload(image_path, 'image/jpeg')) }

    it "ユーザーは写真の詳細ページを表示できること" do
      visit user_memorial_photo_path(user, memorial_photo)
      expect(page).to have_selector('img')
      expect(page).to have_content(memorial_photo.comment)
    end
  end

  describe "写真の編集" do
    let!(:memorial_photo) { create(:memorial_photo, user: user, photo: fixture_file_upload(image_path, 'image/jpeg')) }

    it "ユーザーは写真を編集できること" do
      visit edit_user_memorial_photo_path(user, memorial_photo)
      fill_in 'memorial_photo[comment]', with: '更新されたコメント'
      click_button '更新'
      expect(page).to have_content('遺影画像が正常に更新されました。')
      expect(memorial_photo.reload.comment).to eq('更新されたコメント')
    end
  end

  describe "写真の削除" do
    let!(:memorial_photo) { create(:memorial_photo, user: user, photo: fixture_file_upload(image_path, 'image/jpeg')) }

    it "ユーザーは写真を削除できること" do
      visit edit_user_memorial_photo_path(user, memorial_photo)
      find('.btn-danger', text: '削除', wait: 10).click
      accept_alert
      expect(page).to have_content('画像が正常に削除されました')
    end
  end
end
