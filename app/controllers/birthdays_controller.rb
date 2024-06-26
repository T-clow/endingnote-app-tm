class BirthdaysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_birthday, only: [:edit, :update, :destroy]
  before_action :ensure_no_insurance_policies, only: [:edit, :update, :destroy, :new, :create]

  def new
    @birthday = @user.build_birthday
  end

  def create
    @birthday = @user.build_birthday(birthday_params)
    if @birthday.save
      redirect_to user_insurance_graphs_path(@user), notice: '生年月日が登録されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @birthday.update(birthday_params)
      redirect_to user_insurance_graphs_path(@user), notice: '生年月日が更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @birthday.destroy
    redirect_to "/", notice: '生年月日が削除されました'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_birthday
    @birthday = @user.birthday
  end

  def birthday_params
    params.require(:birthday).permit(:date_of_birth)
  end

  def ensure_no_insurance_policies
    if @user.insurance_policies.any?
      redirect_to user_insurance_graphs_path(@user), alert: '保険契約があるため、生年月日を編集できません。'
    end
  end
end
