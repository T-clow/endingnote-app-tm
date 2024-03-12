class RegistrationsController < Devise::RegistrationsController
  before_action :check_guest_user, only: [:edit, :update]

  def update
    super
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  private

  def check_guest_user
    if resource.email == 'guest@example.com'
      redirect_to "/", alert: 'ゲストユーザーのプロフィールは編集できません。'
    end
  end
end
