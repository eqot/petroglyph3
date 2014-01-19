class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_playlist, only: [:show, :edit, :update, :destroy]

  def new
    @playlist = Playlist.new
    @not_contained_videos = Video.all
  end

  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      update_videos
      redirect_to playlists_path
    else
      render 'new'
    end
  end

  def index
    @playlists = Playlist.paginate(page: params[:page])
  end

  def show
    # @videos = @playlist.contained_videos.paginate(page: params[:page])

    @contained_videos = []
    @contains = @playlist.contains
    @contains.each do |c|
      @contained_videos << Video.find(c.video_id)
    end

    # @videos = @contained_videos.paginate(page: params[:page])
    @videos = @contained_videos
  end

  def edit
    # @contained_videos = @playlist.contained_videos
    @contained_videos = []
    @contains = @playlist.contains
    @contains.each do |c|
      @contained_videos << Video.find(c.video_id)
    end

    @contained_video_ids = []
    @contained_videos.each do |v|
      @contained_video_ids << v.id
    end

    @not_contained_videos = []
    @videos = Video.all
    @videos.each do |v|
      if !@contained_video_ids.include?(v.id)
        @not_contained_videos << v
      end
    end
  end

  def update
    if @playlist.update_attributes(playlist_params)
      update_videos
      flash[:success] = 'Playlist updated.'
      redirect_to @playlist
    else
      render 'edit'
    end
  end

  def destroy
    @playlist.destroy
    flash[:success] = 'Playlist deleted.'
    redirect_to playlists_url
  end

  private

    def playlist_params
      params.require(:playlist).permit(:title, :description)
    end

    def get_playlist
      @playlist = Playlist.find(params[:id])
    end

    def update_videos
      if params[:playlist][:videos2] == 'null'
        return
      end

      old_videos = @playlist.contained_videos
      if params[:playlist][:videos2]
        # new_videos = params[:playlist][:videos].keys
        new_videos = params[:playlist][:videos2].split(',')
      else
        new_videos = []
      end
      # removed_videos = []
      # added_videos = []
      removed_videos = old_videos
      added_videos = new_videos

      # old_videos.each do |v|
      #   index = new_videos.index(v)
      #   if index
      #     new_videos.delete_at(index)
      #   else
      #     removed_videos << v
      #   end
      # end

      # new_videos.each do |v|
      #   index = old_videos.index(v)
      #   if index
      #   else
      #     added_videos << v
      #   end
      # end

      removed_videos.each do |v|
        # @playlist.remove_id!(v)
        @playlist.remove!(v)
      end

      added_videos.each_with_index do |v, index|
        @playlist.add_id!(v, index)
      end
    end

end
