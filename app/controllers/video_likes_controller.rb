class VideoLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @video = Video.find(params[:video_like][:video_id])
    current_user.video_like!(@video)
    respond_to do |format|
      format.html { redirect_to @video }
      format.js
    end
  end

  def destroy
    @video = VideoLike.find(params[:id]).video
    current_user.video_dislike!(@video)
    respond_to do |format|
      format.html { redirect_to @video }
      format.js
    end
  end
end
