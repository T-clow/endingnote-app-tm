require 'rails_helper'

RSpec.describe 'Contacts', type: :system do
  let(:user) { create(:user) }
  let(:contact) { build(:contact) }

  before do
    driven_by(:selenium_remote_chrome)
  end

  context 'ログインしていないユーザー' do
    it '問い合わせを作成して確認画面を表示し、送信できること' do
      visit contacts_path

      fill_in '名前', with: contact.name
      fill_in 'メールアドレス', with: contact.email
      fill_in 'お問い合わせ内容', with: contact.content

      click_button '確認'

      expect(page).to have_content('お問い合わせ内容確認')
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.content)

      click_button '送信'

      expect(page).to have_content('お問い合わせ内容を送信しました')
    end
  end

  context 'ログインしているユーザー' do
    before do
      sign_in user
    end

    it '問い合わせを作成して確認画面を表示し、送信できること' do
      visit contacts_path

      expect(page).to have_field('名前', with: user.username)
      expect(page).to have_field('メールアドレス', with: user.email)

      fill_in 'お問い合わせ内容', with: contact.content

      click_button '確認'

      expect(page).to have_content('お問い合わせ内容確認')
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
      expect(page).to have_content(contact.content)

      click_button '送信'

      expect(page).to have_content('お問い合わせ内容を送信しました')
    end
  end
end
