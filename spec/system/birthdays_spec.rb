require 'rails_helper'

RSpec.describe "生年月日の管理", type: :system, js: true do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "生年月日の登録" do
    it "ユーザーが生年月日を登録できること" do
      visit new_user_birthday_path(user)
      select '1980', from: 'birthday_date_of_birth_1i'
      select '11', from: 'birthday_date_of_birth_2i'
      select '4', from: 'birthday_date_of_birth_3i'
      click_button '登録する'
      expect(page).to have_content('生年月日が登録されました')
      expect(current_path).to eq(user_insurance_graphs_path(user))
    end
  end

  describe "生年月日の更新" do
    let!(:birthday) { Birthday.create!(date_of_birth: Date.new(1958, 11, 4), user: user) }

    it "ユーザーが生年月日を更新できること" do
      visit edit_user_birthday_path(user, birthday)
      select '1990', from: 'birthday_date_of_birth_1i' # 年を選択
      select '9', from: 'birthday_date_of_birth_2i' # 月を選択
      select '10', from: 'birthday_date_of_birth_3i' # 日を選択
      click_button '更新する'

      expect(page).to have_content('生年月日が更新されました')
      expect(current_path).to eq(user_insurance_graphs_path(user))
      expect(birthday.reload.date_of_birth).to eq(Date.new(1990, 9, 10))
    end
  end

  describe "生年月日の削除" do
    let!(:birthday) { Birthday.create!(date_of_birth: Date.new(1990, 9, 10), user: user) }

    it "ユーザーが生年月日を削除できること" do
      visit edit_user_birthday_path(user, birthday)
      find('.btn-danger', text: '削除').click
      accept_alert
      expect(page).to have_content('生年月日が削除されました')
      expect(current_path).to eq("/")
      expect(Birthday.exists?(birthday.id)).to be false
    end
  end
end
