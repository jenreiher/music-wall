class Review < ActiveRecord::Base

  belongs_to :track
  belongs_to :user

  validates :user_track_id, uniqueness: true
  validates :rating, numericality: { minimum: 1, maximum:5 }

end