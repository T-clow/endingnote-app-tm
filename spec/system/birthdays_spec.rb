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

  context "既存の誕生日がある場合" do
    let!(:birthday) { create(:birthday, user: user) }

    describe "生年月日の更新" do
      it "ユーザーが生年月日を更新できること" do
        visit edit_user_birthday_path(user, birthday)
        select '1990', from: 'birthday_date_of_birth_1i'
        select '9', from: 'birthday_date_of_birth_2i'
        select '10', from: 'birthday_date_of_birth_3i'
        click_button '更新する'

        expect(page).to have_content('生年月日が更新されました')
        expect(current_path).to eq(user_insurance_graphs_path(user))
        expect(birthday.reload.date_of_birth).to eq(Date.new(1990, 9, 10))
      end
    end

    describe "生年月日の削除" do
      it "ユーザーが生年月日を削除できること" do
        visit edit_user_birthday_path(user, birthday)
        find('.btn-danger', text: '削除').click
        accept_alert
        expect(page).to have_content('生年月日が削除されました')
        expect(current_path).to eq("/")
        expect(Birthday.exists?(birthday.id)).to be false
      end
    end

    describe "生年月日編集リンクの表示" do
      context "保険契約がない場合" do
        it "生年月日編集リンクが表示されること" do
          visit user_insurance_graphs_path(user)
          expect(page).to have_link(href: edit_user_birthday_path(user))
          expect(page).to have_content("(#{user.birthday.age})")
        end
      end

      context "保険契約がある場合" do
        let!(:insurance_policy) { create(:insurance_policy, user: user) }

        it "生年月日編集リンクが表示されないこと" do
          visit user_insurance_graphs_path(user)
          expect(page).not_to have_link(href: edit_user_birthday_path(user))
          expect(page).to have_content("※生年月日を編集するには保険契約を０にする必要があります。")
        end
      end
    end

    describe "生年月日編集ページへのアクセス" do
      context "保険契約がある場合" do
        let!(:insurance_policy) { create(:insurance_policy, user: user) }

        it "生年月日編集ページにアクセスできないこと" do
          visit edit_user_birthday_path(user, birthday)
          expect(page).to have_content('保険契約があるため、生年月日を編集できません。')
          expect(current_path).to eq(user_insurance_graphs_path(user))
        end
      end
    end
  end
end
