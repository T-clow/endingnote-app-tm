require 'rails_helper'

RSpec.describe "FuneralPreferences", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "新しい葬儀設定を作成" do
    it "ユーザーは新しい葬儀設定を作成できる" do
      visit new_user_funeral_preference_path(user)
      select '家族葬にして欲しい', from: '葬儀の種類'
      select '50万円以下', from: 'ご予算'
      select '10人以下', from: '呼ぶ人'
      select '自宅', from: '場所'
      select '仏教', from: '宗派'
      fill_in '備考', with: '特になし'
      click_button '登録'
      expect(page).to have_content('葬儀設定が正常に作成されました。')
      expect(page).to have_content('家族葬にして欲しい')
    end
  end

  describe "葬儀設定を編集" do
    it "ユーザーは葬儀設定を編集できる" do
      funeral_preference = create(:funeral_preference, user: user)
      visit edit_user_funeral_preference_path(user, funeral_preference)
      select '小さなお葬式にして欲しい', from: '葬儀の種類'
      click_button '更新'
      expect(page).to have_content('葬儀設定が正常に更新されました。')
      expect(page).to have_content('小さなお葬式にして欲しい')
    end
  end

  describe "葬儀設定を表示" do
    it "ユーザーは葬儀設定を表示できる" do
      funeral_preference = create(:funeral_preference, user: user)
      visit user_funeral_preference_path(user, funeral_preference)
      expect(page).to have_content(funeral_preference.funeral_type)
    end
  end

  describe "葬儀設定を削除できること" do
    it "葬儀設定を削除し、成功のメッセージが表示されること" do
      funeral_preference = create(:funeral_preference, user: user)
      visit edit_user_funeral_preference_path(user, funeral_preference)
      find('button.btn-danger', text: 'ご葬儀プランを削除').click
      accept_alert
      expect(page).to have_content("葬儀設定が正常に削除されました。")
    end
  end
end
