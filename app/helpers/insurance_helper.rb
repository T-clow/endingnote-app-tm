module InsuranceHelper
  def calculate_total_amount(insurance_policies, age)
    total_amount = 0
    insurance_policies.each do |policy|
      total_amount += policy.insurance_amount if policy.insurance_period >= age
    end
    total_amount
  end
end
