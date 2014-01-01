class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :contains, -> { order('position ASC') }
  has_many :contained_videos, through: :contains, source: :video

  default_scope -> { order('created_at DESC') }

  validates :title, presence: true
  validates :user_id, presence: true

  def containing?(other_video)
    contains.find_by(video_id: other_video.id)
  end

  def containing_id?(other_video_id)
    contains.find_by(video_id: other_video_id)
  end

  def add!(other_video, position)
    contains.create!(video_id: other_video.id, position: position)
  end

  def add_id!(other_video_id, position)
    contains.create!(video_id: other_video_id, position: position)
  end

  def remove!(other_video)
    contains.find_by(video_id: other_video.id).destroy
  end

  def remove_id!(other_video_id)
    contains.find_by(video_id: other_video_id).destroy
  end
end
