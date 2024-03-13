require 'rails_helper'

RSpec.describe "UserSessions", type: :request do
  let(:user) { create(:user) }

  describe "ログイン" do
    it "ログインできること" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to('/')
    end
  end

  describe "ログアウト" do
    it "ログアウトできること" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to('/')
    end
  end
end
