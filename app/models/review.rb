class Review < ActiveRecord::Base

  belongs_to :track
  belongs_to :user

end