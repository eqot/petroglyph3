class Contain < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :video

  validates :playlist, presence: true
  validates :video, presence: true
end
