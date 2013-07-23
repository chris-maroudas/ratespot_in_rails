class AddArticleAuthorToUser < ActiveRecord::Migration
  def up
		add_column :users, :article_author, :boolean, default: false
  end

	def down
		remove_column :users, :article_author
	end
end
