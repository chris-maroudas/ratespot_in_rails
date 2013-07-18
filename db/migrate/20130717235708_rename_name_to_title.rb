class RenameNameToTitle < ActiveRecord::Migration

  def up
		rename_column :articles, :name, :title
  end

  def down
		rename_column :articles, :title, :name
  end
end
