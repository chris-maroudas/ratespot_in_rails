class AddApprovedToReview < ActiveRecord::Migration

  def up
    add_column :reviews, :approved, :boolean, default: false
  end

  def down
    remove_column :reviews, :approved
  end

end
