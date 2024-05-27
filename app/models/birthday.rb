class Birthday < ApplicationRecord
  belongs_to :user

  def age
    return unless date_of_birth
    today = Time.zone.today
    this_years_birthday = Date.new(today.year, date_of_birth.month, date_of_birth.day)
    age = today.year - date_of_birth.year
    age -= 1 if today < this_years_birthday
    age
  end
end
