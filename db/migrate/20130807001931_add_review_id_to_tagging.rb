class AddReviewIdToTagging < ActiveRecord::Migration
  def up
    add_column :taggings, :review_id, :integer
  end

  def down
    remove_column :taggings, :review_id, :integer
  end
end
