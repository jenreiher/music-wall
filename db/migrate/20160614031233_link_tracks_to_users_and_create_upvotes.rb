class LinkTracksToUsersAndCreateUpvotes < ActiveRecord::Migration
  def change
    # TODO add user_id to tracks
    # TODO create table for upvotes that references users/tracks
    # TODO validate the uniquness with scope of the other

    create_table :upvotes do |t|
      t.references :tracks
      t.references :users
      t.integer :upvote_status

    end

    change_table :tracks do |t|
      t.references :users
    end

    change_table :users do |t|
      t.references :upvotes
    end

  end
end
