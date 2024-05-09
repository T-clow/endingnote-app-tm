class InsuranceGraphsController < ApplicationController
  before_action :set_user

  def index
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
