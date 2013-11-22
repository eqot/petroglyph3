class PlaylistsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :destroy]
  before_action :get_playlist, only: [:show, :edit, :update, :destroy]

  def new
    @playlist = Playlist.new
    @videos = Video.all
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
    @videos = @playlist.contained_videos.paginate(page: params[:page])
  end

  def edit
    @videos = Video.all
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
      old_videos = @playlist.contained_videos
      new_videos = params[:playlist][:videos].keys
      removed_videos = []
      added_videos = []

      old_videos.each do |v|
        index = new_videos.index(v)
        if index
          new_videos.delete_at(index)
        else
          removed_videos << v
        end
      end

      new_videos.each do |v|
        index = old_videos.index(v)
        if index
        else
          added_videos << v
        end
      end

      removed_videos.each do |v|
        @playlist.remove_id!(v)
      end

      added_videos.each do |v|
        @playlist.add_id!(v)
      end
    end

end
