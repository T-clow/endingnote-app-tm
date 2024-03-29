class SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to "/", notice: 'ゲストユーザーとしてログインしました。'
  end
end
