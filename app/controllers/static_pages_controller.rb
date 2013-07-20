class StaticPagesController < ApplicationController

	def home
		@reviews = Review.recent
  end

  def contact
  end

  def about
  end

end
