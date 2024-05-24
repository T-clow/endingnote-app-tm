require 'rails_helper'

RSpec.describe "InsuranceAmountCalculations", type: :system do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let!(:policy1) { create(:insurance_policy, user: user, insurance_amount: 1000, insurance_period: 70) }
  let!(:policy2) { create(:insurance_policy, user: user, insurance_amount: 500, insurance_period: 80) }
  let!(:policy3) { create(:insurance_policy, user: user, insurance_amount: 300, insurance_period: 60) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "保険金額計算" do
    it "正しい年齢を入力して保険金額の合計を表示すること" do
      visit user_insurance_graphs_path(user)
      fill_in '指定年齢で保険金額計算ができます', with: 65
      click_button '計算'
      expect(page).to have_content("#{user.username}様が65歳時点でお亡くなりになると1500万円家族に遺せます")
    end

    it "保険契約がない年齢年齢を入力した場合警告文をを表示すること" do
      visit user_insurance_graphs_path(user)
      fill_in '指定年齢で保険金額計算ができます', with: 99
      click_button '計算'
      expect(page).to have_content("#{user.username}様が99歳時点でお亡くなりになられても遺せるお金はありません")
    end

    it "ユーザーの年齢より低い年齢を入力した場合にエラーメッセージを表示すること" do
      visit user_insurance_graphs_path(user)
      fill_in '指定年齢で保険金額計算ができます', with: 25
      click_button '計算'
      expect(page).to have_content("年齢は#{user.birthday.age}歳以上にしてください。")
    end

    it "100歳より高い年齢を入力した場合にエラーメッセージを表示すること" do
      visit user_insurance_graphs_path(user)
      fill_in '指定年齢で保険金額計算ができます', with: 101
      click_button '計算'
      expect(page).to have_content("年齢は100歳以下で入力してください。")
    end

    it "年齢を入力しなかった場合にエラーメッセージを表示すること" do
      visit user_insurance_graphs_path(user)
      click_button '計算'
      expect(page).to have_content("年齢を入力してください。")
    end
  end
end
