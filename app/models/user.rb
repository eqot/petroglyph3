class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :videos, dependent: :destroy
  has_many :video_likes, dependent: :destroy
  has_many :playlists, dependent: :destroy

  def video_like!(video)
    video_likes.create!(video_id: video.id)
  end

  def video_dislike!(video)
    video_likes.find_by(video_id: video.id).destroy
  end

  def video_like?(video)
    video_likes.find_by(video_id: video.id)
  end

end
