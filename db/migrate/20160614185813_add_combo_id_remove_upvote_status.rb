class AddComboIdRemoveUpvoteStatus < ActiveRecord::Migration
  
  def change
    change_table :upvotes do |t|
      t.remove :upvote_status
      t.integer :user_track_id
    end
  end

end
