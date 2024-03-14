require 'rails_helper'

RSpec.describe 'FuneralPreferences', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it '新規葬儀設定ページを表示できること' do
      get new_funeral_preference_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it '葬儀設定の詳細ページを表示できること' do
      funeral_preference = create(:funeral_preference, user: user)
      get funeral_preference_path(funeral_preference)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    let(:funeral_preference_params) do
      {
        funeral_preference: {
          funeral_type: '家族葬にして欲しい',
          budget: '世間に恥じない一般的な金額にして欲しい',
          invitees: '10人以下',
          location: '自宅',
          sect: '仏教',
        },
      }
    end

    it '葬儀設定を作成できること' do
      expect do
        post funeral_preferences_path, params: funeral_preference_params
      end.to change(FuneralPreference, :count).by(1)
      expect(response).to redirect_to(FuneralPreference.last)
    end
  end

  describe 'GET /edit' do
    it '葬儀設定の編集ページを表示できること' do
      funeral_preference = create(:funeral_preference, user: user)
      get edit_funeral_preference_path(funeral_preference)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH /update' do
    let(:funeral_preference) { create(:funeral_preference, user: user) }
    let(:update_params) do
      {
        funeral_preference: {
          funeral_type: '直葬(火葬場)',
        },
      }
    end

    it '葬儀設定を更新できること' do
      patch funeral_preference_path(funeral_preference), params: update_params
      expect(funeral_preference.reload.funeral_type).to eq '直葬(火葬場)'
      expect(response).to redirect_to(funeral_preference)
    end
  end

  describe 'DELETE /destroy' do
    it '葬儀設定を削除できること' do
      funeral_preference = create(:funeral_preference, user: user)
      expect do
        delete funeral_preference_path(funeral_preference)
      end.to change(FuneralPreference, :count).by(-1)
      expect(response).to redirect_to("/")
    end
  end
end
