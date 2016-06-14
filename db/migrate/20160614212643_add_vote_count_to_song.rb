class AddVoteCountToSong < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.integer :vote_count, :default => 0
    end
  end
end
