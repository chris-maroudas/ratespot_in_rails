class AddImageurlToArticles < ActiveRecord::Migration

	def up
		add_column :articles, :image_url, :string
  end

	def down
		remove_column :articles, :image_url
	end

end
