class StaticPagesController < ApplicationController

  def home
    @reviews = Review.includes(:comments, :user).recent
    @articles = Article.for_slider
    @tags = Tag.recent
  end

end
