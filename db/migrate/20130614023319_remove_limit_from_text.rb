class RemoveLimitFromText < ActiveRecord::Migration
  def up
		change_column :reviews, :content, :text, limit: nil
  end

  def down
	  change_column :reviews, :content, :text, limit: 255
  end
end
