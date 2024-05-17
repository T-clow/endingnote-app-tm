class InsurancePoliciesController < ApplicationController
  before_action :set_user
  before_action :set_insurance_policy, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @insurance_policy = @user.insurance_policies.build
  end

  def edit
  end

  def create
    @insurance_policy = @user.insurance_policies.build(insurance_policy_params)
    if @insurance_policy.save
      redirect_to user_insurance_graphs_path(current_user), notice: '保険証券が登録されました。'
    else
      flash.now[:alert] = '保険証券の登録に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @insurance_policy.update(insurance_policy_params)
      redirect_to user_insurance_graphs_path(current_user), notice: '保険証券が更新されました。'
    else
      flash.now[:alert] = '保険証券の更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @insurance_policy.destroy
    redirect_to user_insurance_graphs_path(current_user), notice: '保険証券が削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_insurance_policy
    @insurance_policy = @user.insurance_policies.find(params[:id])
  end

  def insurance_policy_params
    modified_params = params.require(:insurance_policy).permit(
      :insurance_company, :insurance_type, :insurance_amount,
      :insurance_period, :policy_number, :note, :policy_image
    )
    modified_params[:insurance_period] = "100" if modified_params[:insurance_period] == "終身"
    modified_params
  end
end
