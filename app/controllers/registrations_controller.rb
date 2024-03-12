class RegistrationsController < Devise::RegistrationsController
  before_action :check_guest_user, only: [:edit, :update]

  private

  def check_guest_user
    if resource.email == 'guest@example.com'
      redirect_to "/", alert: 'ゲストユーザーのプロフィールは編集できません。'
    end
  end
end
