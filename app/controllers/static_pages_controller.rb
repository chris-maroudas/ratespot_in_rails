class StaticPagesController < ApplicationController

	def home
		@reviews = Review.limit(10).all
  end

  def contact
  end

  def about
  end

end
