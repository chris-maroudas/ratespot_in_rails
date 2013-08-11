class AddIndexToReviews < ActiveRecord::Migration

  def up
    add_index :reviews, :user_id
  end

  def down
    remove_index :reviews, :user_id
  end

end
