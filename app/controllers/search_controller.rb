class SearchController < ApplicationController

  def index
    @tag = Tag.find_by_name(params[:search])
  end

end
