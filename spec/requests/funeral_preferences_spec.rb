require 'rails_helper'

RSpec.describe 'FuneralPreferences', type: :request do
  let(:user) { create(:user) }
  let(:funeral_preference) { create(:funeral_preference, user: user) }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it '新規葬儀設定ページを表示できること' do
      get new_user_funeral_preference_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it '葬儀設定の詳細ページを表示できること' do
      get user_funeral_preference_path(user, funeral_preference)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:funeral_preference_params) { attributes_for(:funeral_preference) }

    it '葬儀設定を作成できること' do
      expect do
        post user_funeral_preferences_path(user), params: { funeral_preference: funeral_preference_params }
      end.to change(FuneralPreference, :count).by(1)
      expect(response).to redirect_to(user_funeral_preference_path(user, FuneralPreference.last))
    end
  end

  describe 'GET /edit' do
    it '葬儀設定の編集ページを表示できること' do
      get edit_user_funeral_preference_path(user, funeral_preference)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    let(:update_params) { { funeral_type: '直葬(火葬場)' } }

    it '葬儀設定を更新できること' do
      patch user_funeral_preference_path(user, funeral_preference), params: { funeral_preference: update_params }
      expect(funeral_preference.reload.funeral_type).to eq '直葬(火葬場)'
      expect(response).to redirect_to(user_funeral_preference_path(user, funeral_preference))
    end
  end

  describe 'DELETE /destroy' do
    it '葬儀設定を削除できること' do
      funeral_preference
      expect do
        delete user_funeral_preference_path(user, funeral_preference)
      end.to change(FuneralPreference, :count).by(-1)
      expect(response).to redirect_to("/")
    end
  end

  context '備考が200文字を超える場合' do
    let(:long_remarks) { 'a' * 201 }
    let(:funeral_preference_params_with_long_remarks) { attributes_for(:funeral_preference, remarks: long_remarks) }

    it '葬儀設定の作成に失敗すること' do
      expect do
        post user_funeral_preferences_path(user), params: { funeral_preference: funeral_preference_params_with_long_remarks }
      end.not_to change(FuneralPreference, :count)
      expect(response.body).to include '備考は200文字以内にしてください。'
    end
  end

  context '備考が200文字以内の場合' do
    let(:valid_remarks) { 'a' * 200 }
    let(:funeral_preference_params_with_valid_remarks) { attributes_for(:funeral_preference, remarks: valid_remarks) }

    it '葬儀設定を作成できること' do
      expect do
        post user_funeral_preferences_path(user), params: { funeral_preference: funeral_preference_params_with_valid_remarks }
      end.to change(FuneralPreference, :count).by(1)
      expect(response).to redirect_to(user_funeral_preference_path(user, FuneralPreference.last))
    end
  end
end
