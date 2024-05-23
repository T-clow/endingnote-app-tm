class InsuranceGraphsController < ApplicationController
  include InsuranceHelper
  before_action :set_user

  def index
    @user_age = @user.birthday&.age
    @insurance_policies = @user.insurance_policies
    if session[:age].present?
      @age = session.delete(:age)
      @total_amount = session.delete(:total_amount)
    end
  end

  def calculate_insurance_amount_by_age
    @user_age = @user.birthday&.age

    if params[:age].present?
      @age = params[:age].to_i

      if @age < @user_age
        redirect_to user_insurance_graphs_path(@user), alert: "年齢は#{@user_age}歳以上にしてください。"
        return
      elsif @age > 100
        redirect_to user_insurance_graphs_path(@user), alert: '年齢は100歳以下で入力してください。'
        return
      end

      @insurance_policies = @user.insurance_policies
      @total_amount = calculate_total_amount(@insurance_policies, @age)
      session[:age] = @age
      session[:total_amount] = @total_amount
      redirect_to user_insurance_graphs_path(@user)
    else
      redirect_to user_insurance_graphs_path(@user), alert: '年齢を入力してください。'
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
