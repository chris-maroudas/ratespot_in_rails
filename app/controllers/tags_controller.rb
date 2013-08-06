class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.paginate(page: params[:page], per_page: 4)
  end

end
