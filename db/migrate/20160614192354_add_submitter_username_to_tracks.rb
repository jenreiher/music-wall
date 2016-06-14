class AddSubmitterUsernameToTracks < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.string :submitter
    end
  end
end
