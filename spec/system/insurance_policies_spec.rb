require 'rails_helper'

RSpec.describe 'InsurancePolicies', type: :system do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let!(:insurance_policy) { create(:insurance_policy, user: user) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe '保険契約のCRUD操作' do
    it '保険契約の一覧を表示すること' do
      visit user_insurance_graphs_path(user)
      expect(page).to have_content('保険契約一覧')
      expect(page).to have_content(insurance_policy.insurance_company)
    end

    it '保険契約の詳細を表示すること' do
      visit user_insurance_policy_path(user, insurance_policy)
      expect(page).to have_content(insurance_policy.insurance_company)
      expect(page).to have_content(insurance_policy.insurance_type)
      expect(page).to have_content("#{number_with_delimiter(insurance_policy.insurance_amount / 10_000)}万円")
      expect(page).to have_content(insurance_policy.insurance_period == 100 ? "終身" : "#{insurance_policy.insurance_period}歳")
    end

    it '保険契約を作成すること' do
      visit new_user_insurance_policy_path(user)
      fill_in '保険会社', with: 'テスト生命'
      fill_in '保険の種類', with: '医療保険'
      fill_in '保険金額（万円）', with: 500
      fill_in '保険期間（年齢で入力または終身を選択）', with: 90
      fill_in '証券番号', with: '123456'
      fill_in '備考', with: '備考テスト'
      click_button '登録する'
      expect(current_path).to eq(user_insurance_graphs_path(user))
      expect(page).to have_content('保険契約一覧')
      expect(page).to have_content('テスト生命')
    end

    it '保険契約を編集すること' do
      visit edit_user_insurance_policy_path(user, insurance_policy)
      fill_in '保険会社', with: '編集後テスト生命'
      fill_in '保険の種類', with: 'がん保険'
      fill_in '保険金額（万円）', with: 1000
      fill_in '保険期間（年齢で入力または終身を選択）', with: 60
      fill_in '証券番号', with: '654321'
      fill_in '備考', with: '編集後備考'
      click_button '登録する'
      expect(current_path).to eq(user_insurance_graphs_path(user))
      expect(page).to have_content('保険契約一覧')
      expect(page).to have_content('編集後テスト生命')
    end

    it '保険契約を削除すること' do
      visit edit_user_insurance_policy_path(user, insurance_policy)
      find('.btn-danger', text: '削除').click
      accept_alert
      expect(page).to have_content('保険証券が削除されました。')
      expect(current_path).to eq(user_insurance_graphs_path(user))
      expect(InsurancePolicy.exists?(insurance_policy.id)).to be false
    end
  end
end
