class AddImageUrltoReview < ActiveRecord::Migration

  def up
    add_column :reviews, :image_url, :string
  end

  def down
    remove_column :reviews, :image_url
  end

end
