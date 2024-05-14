require 'rails_helper'

RSpec.describe "InsuranceGraphs", type: :system, js: true do
  let(:user) { create(:user) }

  before do
    driven_by(:selenium_remote_chrome)
    sign_in user
    user.create_birthday!(date_of_birth: Date.new(1967, 2, 14))
  end

  describe "保険金額のグラフ表示" do
    it "ユーザーの生年月日に基づいて保険金額のグラフが表示されること" do
      visit user_insurance_graphs_path(user)
      expect(page).to have_css('#myBarChart')
      expect(page).to have_content('保険金額')
    end
  end
end
