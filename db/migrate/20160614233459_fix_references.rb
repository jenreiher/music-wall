class FixReferences < ActiveRecord::Migration
  def change
    change_table :upvotes do |t|
      t.remove :tracks_id
      t.remove :users_id
      t.belongs_to :track
      t.belongs_to :user

    end

    change_table :tracks do |t|
      t.remove :users_id
      t.belongs_to :user
    end

    change_table :users do |t|
      t.remove :upvotes_id
    end
  end
end
