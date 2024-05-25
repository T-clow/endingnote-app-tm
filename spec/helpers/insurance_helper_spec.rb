require 'rails_helper'

RSpec.describe InsuranceHelper, type: :helper do
  let(:user) { create(:user) }
  let!(:birthday) { create(:birthday, user: user) }
  let!(:policy1) { create(:insurance_policy, user: user, insurance_amount: 1000, insurance_period: 70) }
  let!(:policy2) { create(:insurance_policy, user: user, insurance_amount: 500, insurance_period: 80) }
  let!(:policy3) { create(:insurance_policy, user: user, insurance_amount: 300, insurance_period: 60) }

  describe "#calculate_total_amount" do
    context "正しい合計保険金額を計算する" do
      it "年齢65歳のときに正しい合計保険金額を計算できること" do
        total_amount = helper.calculate_total_amount([policy1, policy2, policy3], 65)
        expect(total_amount).to eq(15000000)
      end

      it "年齢75歳のときに正しい合計保険金額を計算できること" do
        total_amount = helper.calculate_total_amount([policy1, policy2, policy3], 75)
        expect(total_amount).to eq(5000000)
      end

      it "年齢85歳のときに正しい合計保険金額を計算できること" do
        total_amount = helper.calculate_total_amount([policy1, policy2, policy3], 85)
        expect(total_amount).to eq(0)
      end
    end
  end

  describe "#calculate_insurance_amounts_for_graph" do
    let(:user_age) { 65 }

    it "年齢65歳のときに正しい合計保険金額を計算できること" do
      amounts = helper.calculate_insurance_amounts_for_graph([policy1, policy2, policy3], user_age)
      expect(amounts[0]).to eq(15000000)
    end

    it "年齢75歳のときに正しい合計保険金額を計算できること" do
      amounts = helper.calculate_insurance_amounts_for_graph([policy1, policy2, policy3], user_age)
      expect(amounts[10]).to eq(5000000)
    end

    it "年齢85歳のときに正しい合計保険金額を計算できること" do
      amounts = helper.calculate_insurance_amounts_for_graph([policy1, policy2, policy3], user_age)
      expect(amounts[20]).to eq(0)
    end

    it "保険が全くない場合にすべて0になること" do
      amounts = helper.calculate_insurance_amounts_for_graph([], user_age)
      expect(amounts.all? { |amount| amount == 0 }).to be true
    end
  end
end
