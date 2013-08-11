class AddIndexToArticles < ActiveRecord::Migration
  def up
    add_index :articles, :user_id
  end

  def down
    remove_index :articles, :user_id
  end

end
