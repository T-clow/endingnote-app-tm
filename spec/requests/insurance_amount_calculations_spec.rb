require 'rails_helper'

RSpec.describe "InsuranceAmountCalculations", type: :request do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let!(:policy1) { create(:insurance_policy, user: user, insurance_amount: 1000, insurance_period: 70) }
  let!(:policy2) { create(:insurance_policy, user: user, insurance_amount: 500, insurance_period: 80) }
  let!(:policy3) { create(:insurance_policy, user: user, insurance_amount: 300, insurance_period: 60) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "インデックスページが正常に表示されること" do
      get user_insurance_graphs_path(user)
      expect(response).to have_http_status(:success)
    end

    it "保険ポリシーが表示されること" do
      get user_insurance_graphs_path(user)
      expect(response.body).to include(policy1.insurance_company)
      expect(response.body).to include(policy2.insurance_company)
      expect(response.body).to include(policy3.insurance_company)
    end

    context "年月が経過した場合" do
      it "満期を過ぎた保険契約も表示されること" do
        travel_to Time.zone.local(2030, 1, 1) do
          get user_insurance_graphs_path(user)
          expect(response.body).to include(policy1.insurance_company)
          expect(response.body).to include(policy2.insurance_company)
          expect(response.body).to include(policy3.insurance_company)
        end
      end
    end
  end

  describe "POST /calculate_insurance_amount_by_age" do
    context "有効な年齢を指定した場合" do
      it "保険金額の合計を計算してインデックスページにリダイレクトされること" do
        post calculate_insurance_amount_by_age_user_insurance_graphs_path(user), params: { age: 65 }
        expect(response).to redirect_to(user_insurance_graphs_path(user))
        follow_redirect!
        expect(response.body).to include("1500000")
      end
    end

    context "ユーザーの年齢より低い年齢を指定した場合" do
      it "インデックスページにリダイレクトされ、アラートメッセージが表示されること" do
        post calculate_insurance_amount_by_age_user_insurance_graphs_path(user), params: { age: 25 }
        expect(response).to redirect_to(user_insurance_graphs_path(user))
        follow_redirect!
        expect(response.body).to include("年齢は34歳以上にしてください。")
      end
    end

    context "100歳より高い年齢を指定した場合" do
      it "インデックスページにリダイレクトされ、アラートメッセージが表示されること" do
        post calculate_insurance_amount_by_age_user_insurance_graphs_path(user), params: { age: 101 }
        expect(response).to redirect_to(user_insurance_graphs_path(user))
        follow_redirect!
        expect(response.body).to include("年齢は100歳以下で入力してください。")
      end
    end

    context "年齢を指定しなかった場合" do
      it "インデックスページにリダイレクトされ、アラートメッセージが表示されること" do
        post calculate_insurance_amount_by_age_user_insurance_graphs_path(user), params: { age: nil }
        expect(response).to redirect_to(user_insurance_graphs_path(user))
        follow_redirect!
        expect(response.body).to include("年齢を入力してください。")
      end
    end
  end
end
