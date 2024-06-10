require 'rails_helper'

RSpec.describe Devise::Mailer, type: :mailer do
  describe 'パスワード再設定メールの送信' do
    let(:user) { create(:user) }
    let(:mail) { Devise::Mailer.reset_password_instructions(user, "faketoken") }

    it '正しい送信者のメールアドレスを持っていること' do
      expect(mail.from).to include(ENV['MAIL_ADDRESS'])
    end

    it '正しい受信者のメールアドレスを持っていること' do
      expect(mail.to).to include(user.email)
    end

    it '正しい件名を持っていること' do
      expect(mail.subject).to eq('パスワードの再設定について')
    end

    it 'メールの本文に正しい内容が含まれていること' do
      expect(mail.body.encoded).to include('faketoken')
      expect(mail.body.encoded).to include(user.email)
    end
  end
end
