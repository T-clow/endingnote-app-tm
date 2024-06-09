require 'rails_helper'

RSpec.describe "Birthdays", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { date_of_birth: Date.new(1990, 9, 10) } }

  before do
    sign_in user
  end

  describe "POST /create" do
    it "新しい生年月日が作成されること" do
      post user_birthday_path(user), params: { birthday: valid_attributes }
      expect(Birthday.find_by(user: user).date_of_birth).to eq(Date.new(1990, 9, 10))
      expect(response).to redirect_to(user_insurance_graphs_path(user))
    end
  end

  context "既存の誕生日がない場合" do
    describe "GET /new" do
      it "生年月日登録ページにアクセスできること" do
        get new_user_birthday_path(user)
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "既存の誕生日がある場合" do
    let!(:birthday) { create(:birthday, user: user) }

    describe "GET /edit" do
      context "保険契約がない場合" do
        it "生年月日編集ページにアクセスできること" do
          get edit_user_birthday_path(user, birthday)
          expect(response).to be_successful
        end
      end

      context "保険契約がある場合" do
        let!(:insurance_policy) { create(:insurance_policy, user: user) }

        it "生年月日編集ページにアクセスできないこと" do
          get edit_user_birthday_path(user, birthday)
          expect(response).to redirect_to(user_insurance_graphs_path(user))
          expect(flash[:alert]).to eq('保険契約があるため、生年月日を編集できません。')
        end
      end
    end

    describe "PATCH /update" do
      it "生年月日が更新されること" do
        patch user_birthday_path(user, birthday), params: { birthday: { date_of_birth: Date.new(1958, 11, 4) } }
        birthday.reload
        expect(birthday.date_of_birth).to eq(Date.new(1958, 11, 4))
        expect(response).to redirect_to(user_insurance_graphs_path(user))
      end
    end

    describe "DELETE /destroy" do
      it "要求された生年月日が削除されること" do
        delete user_birthday_path(user, birthday)
        expect(Birthday.find_by(user: user)).to be_nil
        expect(response).to redirect_to("/")
      end
    end
  end

  describe "InsuranceGraphs GET /index" do
    let!(:birthday) { create(:birthday, user: user) }

    context "保険契約がない場合" do
      it "生年月日編集リンクが表示されること" do
        get user_insurance_graphs_path(user)
        expect(response.body).to include(edit_user_birthday_path(user))
        expect(response.body).to include("(#{user.birthday.age})")
      end
    end

    context "保険契約がある場合" do
      let!(:insurance_policy) { create(:insurance_policy, user: user) }

      it "生年月日編集リンクが表示されないこと" do
        get user_insurance_graphs_path(user)
        expect(response.body).not_to include(edit_user_birthday_path(user))
        expect(response.body).to include("※生年月日を編集するには保険契約を０にする必要があります。")
      end
    end
  end
end
