class VideosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  # before_action :get_video, only: [:show, :edit, :update, :destroy]

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.build(video_params)
    if @video.save
      redirect_to videos_path
    else
      render 'new'
    end
  end

  def index
    @videos = Video.paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      flash[:success] = "Video updated."
      redirect_to @video
    else
      render 'edit'
    end
  end

  def destroy
    @video.destroy
    flash[:success] = "Video deleted."
    redirect_to videos_url
  end

  private

    def video_params
      params.require(:video).permit(:url, :title, :description, :duration)
    end

    def get_video
      @video = Video.find(params[:id])
    end

end
