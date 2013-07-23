class StaticPagesController < ApplicationController

	def home
		@reviews = Review.recent
		@articles = Article.for_slider
  end

  def contact
  end

  def about
  end

end
