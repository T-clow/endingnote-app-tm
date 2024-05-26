require 'rails_helper'

RSpec.describe "InsuranceGraphs", type: :system, js: true do
  include InsuranceHelper

  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let!(:policy1) { create(:insurance_policy, user: user, insurance_amount: 1000, insurance_period: 70) }
  let!(:policy2) { create(:insurance_policy, user: user, insurance_amount: 500, insurance_period: 80) }
  let!(:policy3) { create(:insurance_policy, user: user, insurance_amount: 300, insurance_period: 60) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
  end

  describe "保険金額のグラフ表示" do
    it "ユーザーの生年月日に基づいて保険金額のグラフが表示されること" do
      visit user_insurance_graphs_path(user)
      expect(page).to have_css('#myBarChart')
    end

    it "最小年齢がユーザーの年齢と同じであること" do
      visit user_insurance_graphs_path(user)
      user_age = user.birthday.age
      chart_container = find('.chart-container')
      expect(chart_container['data-age']).to eq(user_age.to_s)
    end

    it "保険金額が正しく反映されていること" do
      visit user_insurance_graphs_path(user)
      insurance_amounts = calculate_insurance_amounts_for_graph([policy1, policy2, policy3], user.birthday.age)
      chart_container = find('.chart-container')
      expect(chart_container['data-insurance-amounts']).to eq(insurance_amounts.to_json)
    end
  end
end
