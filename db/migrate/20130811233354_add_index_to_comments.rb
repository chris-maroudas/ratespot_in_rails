class AddIndexToComments < ActiveRecord::Migration
  def up
    add_index :comments, :user_id
    add_index :comments, :article_id
    add_index :comments, :review_id
  end

  def down
    remove_index :comments, :user_id
    remove_index :comments, :article_id
    remove_index :comments, :review_id
  end
end
