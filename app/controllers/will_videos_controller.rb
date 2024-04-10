class WillVideosController < ApplicationController
  before_action :set_user

  def new
    @will_video = WillVideo.new
  end

  def create
    @will_video = @user.will_videos.build(will_video_params)
    if @will_video.save
      redirect_to [@user, @will_video], notice: '遺言動画をアップロードしました。'
    else
      flash.now[:alert] = '動画を選択してください。'
      render :new, status: :unprocessable_entity
    end
  rescue ActionController::ParameterMissing
    @will_video = @user.will_videos.build
    flash.now[:alert] = '動画ファイルを選択してください。'
    render :new, status: :bad_request
  end

  def show
    @will_video = WillVideo.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @will_video = @user.will_videos.find(params[:id])
  end

  def destroy
    @will_video = @user.will_videos.find(params[:id])
    @will_video.destroy
    redirect_to "/", notice: '動画が正常に削除されました。'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def will_video_params
    params.require(:will_video).permit(:video)
  end
end
