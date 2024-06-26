class FuneralPreferencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_funeral_preference, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.find(params[:user_id])
    @funeral_preference = @user.funeral_preferences.new
  end

  def create
    @funeral_preference = current_user.funeral_preferences.build(funeral_preference_params)
    if @funeral_preference.save
      redirect_to user_funeral_preference_path(current_user, @funeral_preference), notice: '葬儀設定が正常に作成されました。'
    else
      flash[:alert] = '葬儀設定の作成に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @funeral_preference = current_user.funeral_preference
    if @funeral_preference.nil?
      redirect_to new_funeral_preference_path, alert: '葬儀の設定がまだされていません。'
    end
  end

  def edit
    set_selections
  end

  def update
    if @funeral_preference.update(funeral_preference_params)
      redirect_to user_funeral_preference_path(current_user, @funeral_preference), notice: '葬儀設定が正常に更新されました。'
    else
      set_selections
      flash[:alert] = '葬儀設定の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @funeral_preference.destroy
    redirect_to "/", notice: '葬儀設定が正常に削除されました。'
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      redirect_to root_path, alert: "指定されたユーザーが見つかりません。"
    end
  end

  def set_funeral_preference
    @funeral_preference = @user.funeral_preferences.find_by(id: params[:id])
    if @funeral_preference.nil?
      redirect_to new_user_funeral_preference_path(@user), alert: '葬儀の設定がまだされていません。'
    end
  end

  def funeral_preference_params
    params.require(:funeral_preference).permit(:funeral_type, :budget, :invitees, :location, :sect, :remarks)
  end

  def set_selections
    @funeral_types = FuneralPreference::FUNERAL_TYPES
    @budgets = FuneralPreference::BUDGETS
    @invitees_options = FuneralPreference::INVITEES
    @locations = FuneralPreference::LOCATIONS
    @sects = FuneralPreference::SECTS
  end
end
