class Review < ActiveRecord::Base

  belongs_to :track
  belongs_to :user

  validates :user_track_id, uniqueness: true

end