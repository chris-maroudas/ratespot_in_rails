class AddIndexToTags < ActiveRecord::Migration
  def up
    add_index :taggings, :review_id
    add_index :taggings, :tag_id
    add_index :taggings, :article_id
  end

  def down
    remove_index :taggings, :review_id
    remove_index :taggings, :tag_id
    remove_index :taggings, :article_id
  end
end
