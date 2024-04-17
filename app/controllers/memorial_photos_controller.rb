class MemorialPhotosController < ApplicationController
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  def index
    @memorial_photos = @user.memorial_photos.all
  end

  def show
    @memorial_photo  = MemorialPhoto .find(params[:id])
  end

  def new
    @memorial_photo = @user.memorial_photos.new
  end

  def create
    @memorial_photo = @user.memorial_photos.build(memorial_photo_params)
    if @memorial_photo.save
      redirect_to [@user, @memorial_photo], notice: ' 遺影画像をアップロードしました。'
    else
      flash.now[:alert] = '画像を選択してください。'
      render :new, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    @memorial_photo = @user.memorial_photos.build
    flash.now[:alert] = '画像ファイルを選択してください。'
    render :new, status: :bad_request
  end

  def edit
    @user = User.find(params[:user_id])
    @memorial_photo = @user.memorial_photos.find(params[:id])
  end

  def update
    @memorial_photo = @user.memorial_photos.find(params[:id])
    if @memorial_photo.update(memorial_photo_params)
      redirect_to [@user, @memorial_photo], notice: '遺影画像が正常に更新されました。'
    else
      flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @memorial_photo = @user.memorial_photos.find(params[:id])
    @memorial_photo.destroy
    redirect_to "/", notice: '画像が正常に削除されました'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def memorial_photo_params
    params.require(:memorial_photo).permit(:photo, :comment)
  end
end
