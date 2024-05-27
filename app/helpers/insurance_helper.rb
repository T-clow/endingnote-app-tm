module InsuranceHelper
  def calculate_total_amount(insurance_policies, age)
    total_amount = 0
    insurance_policies.each do |policy|
      total_amount += policy.insurance_amount if policy.insurance_period >= age
    end
    total_amount
  end

  def calculate_insurance_amounts_for_graph(insurance_policies, user_age)
    amounts = Array.new(101 - user_age, 0)
    (user_age..100).each do |age|
      amounts[age - user_age] = calculate_total_amount(insurance_policies, age)
    end
    amounts
  end
end
