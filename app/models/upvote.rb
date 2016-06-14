class Upvote < ActiveRecord::Base

  belongs_to :track
  belongs_to :user

  validates :user_track_id, uniqueness: true

  after_create :increase_vote_count

  def increase_vote_count
    self.track.vote_count += 1
    track.save
  end

end