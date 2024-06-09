require 'rails_helper'

RSpec.describe Birthday, type: :model do
  describe '#age' do
    let(:user) { create(:user) }
    let(:birthday) { create(:birthday, user: user,) }

    context '誕生日より以前の場合' do
      it '誕生日前の年齢が返ること' do
        travel_to '2023/12/31 23:59'.in_time_zone do
          expect(birthday.age).to eq 33
        end
      end
    end

    context '誕生日以降の場合' do
      it '誕生日を過ぎた年齢が返ること' do
        travel_to '2024/01/01 00:00'.in_time_zone do
          expect(birthday.age).to eq 34
        end
      end
    end
  end
end
