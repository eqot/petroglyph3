class Video < ActiveRecord::Base
  belongs_to :user

  has_many :video_likes
  has_many :likes, through: :video_likes, source: :user

  has_many :contains
  has_many :containers, through: :contains

  default_scope -> { order('created_at DESC') }
end
