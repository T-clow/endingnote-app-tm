require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do
  describe 'send_mail' do
    let(:contact) { build(:contact) }
    let(:mail) { ContactMailer.send_mail(contact) }

    it '正しい送信者のメールアドレスを持っていること' do
      expect(mail.from).to include(contact.email)
    end

    it '正しい受信者のメールアドレスを持っていること' do
      expect(mail.to).to include(ENV['MAIL_ADDRESS'])
    end

    it '正しい件名を持っていること' do
      expect(mail.subject).to eq('エンディングノートより問い合わせが届きました')
    end

    it 'メールの本文に問い合わせ内容が含まれていること' do
      expect(mail.body.encoded).to include(contact.name)
      expect(mail.body.encoded).to include(contact.email)
      expect(mail.body.encoded).to include(contact.content)
    end
  end
end
