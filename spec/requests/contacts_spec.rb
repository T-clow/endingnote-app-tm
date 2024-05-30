require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /index" do
    it 'お問い合わせ作成ページにアクセスできること' do
      get contacts_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("お問い合わせ")
    end
  end

  describe "POST /confirm" do
    context "有効なパラメータの場合" do
      let(:valid_attributes) { attributes_for(:contact) }

      it 'お問い合わせ内容確認が表示されること' do
        post confirm_contacts_path, params: { contact: valid_attributes }
        expect(response.body).to include("お問い合わせ内容確認")
      end
    end

    context "無効なパラメータの場合" do
      let(:invalid_attributes) { { contact: { name: '', email: 'invalid_email', content: '' } } }

      it 'お問い合わせ作成ページに戻ること' do
        post confirm_contacts_path, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("お問い合わせ")
      end
    end
  end

  describe "POST /done" do
    context "有効なパラメータの場合" do
      let(:contact) { build(:contact) }
      let(:valid_attributes) { attributes_for(:contact) }
      let(:sender_email) { contact.email }
      let(:receiver_email) { ENV['MAIL_ADDRESS'] }

      it 'メールを送信すること' do
        expect do
          post done_contacts_path, params: { contact: valid_attributes }
        end.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it '完了ページが表示されること' do
        post done_contacts_path, params: { contact: valid_attributes }
        expect(response.body).to include("お問い合わせ内容を送信しました")
      end

      it '送信されたメールの内容が正しくあること' do
        post done_contacts_path, params: { contact: valid_attributes }
        mail = ActionMailer::Base.deliveries.last
        expect(mail.from).to include(sender_email)
        expect(mail.to).to include(receiver_email)
        expect(mail.subject).to eq('エンディングノートより問い合わせが届きました')
      end
    end

    context "確認画面から前の画面に戻る場合" do
      let(:valid_attributes_with_back) { attributes_for(:contact).merge(back: 'true') }

      it '入力データが表示されたままお問合せページに戻ること' do
        post done_contacts_path, params: { contact: valid_attributes_with_back }
        expect(response.body).to include("お問い合わせ")
      end
    end
  end

  describe "GET /index with user signed in" do
    let(:user) { create(:user) }

    it 'ログインしているときに名前とメールアドレスが設定されていること' do
      sign_in user
      get contacts_path
      expect(response.body).to include("value=\"#{user.username}\"")
      expect(response.body).to include("value=\"#{user.email}\"")
    end
  end
end
