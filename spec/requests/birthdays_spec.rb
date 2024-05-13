require 'rails_helper'

RSpec.describe "Birthdays", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { date_of_birth: Date.new(1990, 9, 10) } }

  before do
    sign_in user
  end

  describe "GET /new" do
    it "生年月日登録ページにアクセスできること" do
      get new_user_birthday_path(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "新しい生年月日が作成されること" do
      expect do
        post user_birthday_path(user), params: { birthday: valid_attributes }
      end.to change(Birthday, :count).by(1)
      expect(response).to redirect_to(user_insurance_graphs_path(user))
    end
  end

  describe "GET /edit" do
    it "生年月日編集ページにアクセスできること" do
      birthday = Birthday.create! valid_attributes.merge(user: user)
      get edit_user_birthday_path(user, birthday)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    it "生年月日が更新されること" do
      birthday = Birthday.create! valid_attributes.merge(user: user)
      updated_date = { date_of_birth: Date.new(1958, 11, 04) }
      patch user_birthday_path(user, birthday), params: { birthday: updated_date }
      birthday.reload
      expect(birthday.date_of_birth).to eq(Date.new(1958, 11, 04))
      expect(response).to redirect_to(user_insurance_graphs_path(user))
    end
  end

  describe "DELETE /destroy" do
    it "要求された生年月日が削除されること" do
      birthday = Birthday.create! valid_attributes.merge(user: user)
      expect do
        delete user_birthday_path(user, birthday)
      end.to change(Birthday, :count).by(-1)
      expect(response).to redirect_to("/")
    end
  end
end
