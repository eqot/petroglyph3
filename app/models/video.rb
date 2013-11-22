class Video < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }

  has_many :video_likes
  has_many :likes, through: :video_likes, source: :user
end
