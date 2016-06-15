class AddSongRatings < ActiveRecord::Migration

  def change
    create_table :reviews do |t|
      t.belongs_to :track
      t.belongs_to :user
      t.string :content
      t.integer :rating, :default => 0
      t.string :user_track_id
    end
  end

end
