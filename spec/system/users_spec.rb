require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_remote_chrome)
  end

  describe "新規登録ができること" do
    it "新規登録を完了し、成功のメッセージが表示されること" do
      visit new_user_registration_path
      fill_in "Eメール", with: "test@example.com"
      fill_in "password-1", with: "password"
      fill_in "password-2", with: "password"
      fill_in "電話番号", with: "1234567890"
      fill_in "お名前", with: "テスト太郎"
      fill_in "ユーザ名", with: "testuser"
      click_button "新規登録"
      expect(page).to have_content("アカウント登録が完了しました。")
    end
  end

  describe "プロフィールを編集できること" do
    it "プロフィールを編集し、成功のメッセージが表示されること" do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      fill_in "Eメール", with: "edited@example.com"
      fill_in "password-3", with: user.password
      click_button "更新"
      expect(page).to have_content("アカウント情報を変更しました。")
    end
  end

  describe "ゲストログインができること" do
    it "ゲストログインを行い、成功のメッセージが表示されること" do
      visit "/"
      click_on "ゲスト"
      expect(page).to have_content("ゲストユーザーとしてログインしました。")
    end
  end

  describe "アカウント削除ができること" do
    it "アカウントを削除し、成功のメッセージが表示されること" do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      fill_in "password-3", with: user.password
      find('button', text: 'アカウントを削除').click
      accept_alert
      expect(page).to have_content("アカウントを削除しました。")
    end
  end

  describe "パスワード再設定ができること" do
    it "パスワード再設定のメールが送信されること" do
      visit new_user_password_path
      fill_in "メールアドレス", with: user.email
      click_button "再設定リンクを上記アドレスに送信"
      expect(page).to have_content("パスワードの再設定について数分以内にメールでご連絡いたします。")
    end

    it "パスワードを再設定し、成功のメッセージが表示されること" do
      token = user.send_reset_password_instructions
      visit edit_user_password_path(reset_password_token: token)
      fill_in "password-1", with: "newpassword"
      fill_in "password-2", with: "newpassword"
      click_button "パスワードを再設定する"
      expect(page).to have_content("パスワードが正しく変更されました。")
    end
  end
end
