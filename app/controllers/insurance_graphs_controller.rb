class InsuranceGraphsController < ApplicationController
  before_action :set_user

  def index
    @user_age = current_user.birthday&.age
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
