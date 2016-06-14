class ChangeUserTracksIdToS < ActiveRecord::Migration
  def change
    change_table :upvotes do |t|
      t.remove :user_track_id
      t.string :user_track_id
    end
  end
end
