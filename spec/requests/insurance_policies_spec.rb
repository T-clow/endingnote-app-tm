require 'rails_helper'

RSpec.describe "InsurancePolicies", type: :request do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let(:insurance_policy) { create(:insurance_policy, user: user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "indexページを表示すること" do
      get user_insurance_graphs_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "showページを表示すること" do
      get user_insurance_policy_path(user, insurance_policy)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "newページを表示すること" do
      get new_user_insurance_policy_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "editページを表示すること" do
      get edit_user_insurance_policy_path(user, insurance_policy)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "有効なパラメータの場合" do
      let(:valid_params) { attributes_for(:insurance_policy).merge(user_id: user.id) }

      it "新しい保険契約を作成すること" do
        expect do
          post user_insurance_policies_path(user), params: { insurance_policy: valid_params }
        end.to change(InsurancePolicy, :count).by(1)
        expect(response).to redirect_to(user_insurance_graphs_path(user))
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_params) do
        {
          insurance_policy: {
            insurance_company: "",
            insurance_type: "",
            insurance_amount: nil,
            insurance_period: nil,
          },
        }
      end

      it "新しい保険契約を作成しないこと" do
        expect do
          post user_insurance_policies_path(user), params: invalid_params
        end.not_to change(InsurancePolicy, :count)
      end
    end
  end

  describe "PATCH /update" do
    context "有効なパラメータの場合" do
      let(:new_attributes) do
        {
          insurance_company: "新しいテスト生命",
          insurance_type: "医療保険",
          insurance_amount: 200,
          insurance_period: 70,
        }
      end

      it "指定した保険契約を更新すること" do
        patch user_insurance_policy_path(user, insurance_policy), params: { insurance_policy: new_attributes }
        insurance_policy.reload
        expect(insurance_policy.insurance_company).to eq("新しいテスト生命")
        expect(insurance_policy.insurance_type).to eq("医療保険")
        expect(insurance_policy.insurance_amount).to eq(2_000_000)
        expect(insurance_policy.insurance_period).to eq(70)
        expect(response).to redirect_to(user_insurance_graphs_path(user))
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_attributes) do
        {
          insurance_company: "",
          insurance_type: "",
          insurance_amount: nil,
          insurance_period: nil,
        }
      end

      it "指定した保険契約を更新しないこと" do
        patch user_insurance_policy_path(user, insurance_policy), params: { insurance_policy: invalid_attributes }
        insurance_policy.reload
        expect(insurance_policy.insurance_company).not_to eq("")
      end
    end
  end

  describe "DELETE /destroy" do
    it "指定した保険契約を削除すること" do
      insurance_policy
      expect do
        delete user_insurance_policy_path(user, insurance_policy)
      end.to change(InsurancePolicy, :count).by(-1)
      expect(response).to redirect_to(user_insurance_graphs_path(user))
    end
  end
end
