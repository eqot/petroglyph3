class Contain < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :video

  acts_as_list scope: :playlist

  validates :playlist, presence: true
  validates :video, presence: true
end
